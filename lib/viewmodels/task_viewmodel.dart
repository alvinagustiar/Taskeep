import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskeep/models/task.dart';
import 'package:taskeep/models/action_record.dart';
import 'package:taskeep/services/supabase_service.dart';
import 'package:taskeep/services/notification_service.dart';
import 'package:taskeep/services/graph_service.dart';

/// Provider for TaskViewModel
final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<Task>>((ref) {
  final supabase = SupabaseService();
  final notification = NotificationService();
  final graph = GraphService();
  return TaskViewModel(supabase, notification, graph);
});

/// StateNotifier for managing list of tasks and undo/redo actions
class TaskViewModel extends StateNotifier<List<Task>> {
  final SupabaseService _supabaseService;
  final NotificationService _notificationService;
  final GraphService _graphService;

  // Undo/redo stacks
  final ActionStack _undoStack = ActionStack();
  final ActionStack _redoStack = ActionStack();

  // Reminder queue
  final Queue<Task> _reminderQueue = Queue<Task>();

  TaskViewModel(
    this._supabaseService,
    this._notificationService,
    this._graphService,
  ) : super([]) {
    _init();
  }

  Future<void> _init() async {
    try {
      // Load tasks
      await loadTasks();

      // Initialize notifications
      await _notificationService.initialize();

      // Subscribe to real-time updates
      _supabaseService.streamTasks().listen(
        (tasks) {
          state = tasks;
          _updateGraphDependencies(tasks);
        },
        onError: (error) {
          throw Exception('Failed to stream tasks: $error');
        },
      );
    } catch (e) {
      throw Exception('Failed to initialize TaskViewModel: $e');
    }
  }

  void _updateGraphDependencies(List<Task> tasks) {
    _graphService.clear();
    for (var task in tasks) {
      if (task.dependencies.isNotEmpty) {
        for (var depId in task.dependencies) {
          _graphService.addDependency(depId, task.id);
        }
      }
    }
  }

  Future<void> loadTasks() async {
    try {
      final tasks = await _supabaseService.getTasks();
      state = tasks;
      _updateGraphDependencies(tasks);
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      // Record action for undo
      _undoStack.push(ActionRecord(
        id: DateTime.now().toIso8601String(),
        type: ActionType.createTask,
        timestamp: DateTime.now(),
        previousState: {},
        newState: task.toJson(),
        entityId: task.id,
        description: 'Created task: ${task.title}',
      ));
      _redoStack.clear();

      // Create task in database
      final createdTask = await _supabaseService.createTask(task);

      // Update local state
      state = [...state, createdTask];

      // Update dependencies
      if (createdTask.dependencies.isNotEmpty) {
        for (var depId in createdTask.dependencies) {
          _graphService.addDependency(depId, createdTask.id);
        }
      }

      // Schedule reminder if needed
      if (createdTask.dueDate != null) {
        enqueueReminder(createdTask);
        await processReminders();
      }
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final oldTask = state.firstWhere((t) => t.id == task.id);

      _undoStack.push(ActionRecord(
        id: DateTime.now().toIso8601String(),
        type: ActionType.updateTask,
        timestamp: DateTime.now(),
        previousState: oldTask.toJson(),
        newState: task.toJson(),
        entityId: task.id,
        description: 'Updated task: ${task.title}',
      ));
      _redoStack.clear();

      // Update task in database
      final updatedTask = await _supabaseService.updateTask(task);

      // Update local state
      state = [
        for (final t in state)
          if (t.id == task.id) updatedTask else t,
      ];

      // Update dependencies if changed
      if (oldTask.dependencies != updatedTask.dependencies) {
        // Remove old dependencies
        for (var depId in oldTask.dependencies) {
          _graphService.removeDependency(depId, task.id);
        }
        // Add new dependencies
        for (var depId in updatedTask.dependencies) {
          _graphService.addDependency(depId, task.id);
        }
      }

      // Update reminder if needed
      if (updatedTask.dueDate != null &&
          oldTask.dueDate != updatedTask.dueDate) {
        enqueueReminder(updatedTask);
        await processReminders();
      }
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final oldTask = state.firstWhere((t) => t.id == id);

      _undoStack.push(ActionRecord(
        id: DateTime.now().toIso8601String(),
        type: ActionType.deleteTask,
        timestamp: DateTime.now(),
        previousState: oldTask.toJson(),
        newState: {},
        entityId: id,
        description: 'Deleted task: ${oldTask.title}',
      ));
      _redoStack.clear();

      // Remove from database
      await _supabaseService.deleteTask(id);

      // Update local state
      state = state.where((t) => t.id != id).toList();

      // Remove dependencies
      for (var depId in oldTask.dependencies) {
        _graphService.removeDependency(depId, id);
      }

      // Cancel any scheduled notifications
      if (oldTask.dueDate != null) {
        await _notificationService.cancelNotification(id.hashCode);
      }
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<void> undo() async {
    if (_undoStack.isEmpty) return;
    try {
      final action = _undoStack.pop();
      if (action == null) return;

      switch (action.type) {
        case ActionType.createTask:
          await deleteTask(action.entityId!);
          break;
        case ActionType.updateTask:
          await updateTask(Task.fromJson(action.previousState));
          break;
        case ActionType.deleteTask:
          await addTask(Task.fromJson(action.previousState));
          break;
        default:
          // Handle other action types if needed
          break;
      }
      _redoStack.push(action);
    } catch (e) {
      throw Exception('Failed to undo action: $e');
    }
  }

  Future<void> redo() async {
    if (_redoStack.isEmpty) return;
    try {
      final action = _redoStack.pop();
      if (action == null) return;

      switch (action.type) {
        case ActionType.createTask:
          await addTask(Task.fromJson(action.newState));
          break;
        case ActionType.updateTask:
          await updateTask(Task.fromJson(action.newState));
          break;
        case ActionType.deleteTask:
          await deleteTask(action.entityId!);
          break;
        default:
          // Handle other action types if needed
          break;
      }
      _undoStack.push(action);
    } catch (e) {
      throw Exception('Failed to redo action: $e');
    }
  }

  void enqueueReminder(Task task) {
    if (task.dueDate != null) {
      _reminderQueue.add(task);
    }
  }

  Future<void> processReminders() async {
    while (_reminderQueue.isNotEmpty) {
      final task = _reminderQueue.removeFirst();
      if (task.dueDate != null && task.dueDate!.isAfter(DateTime.now())) {
        await _notificationService.scheduleTaskReminder(
          id: task.id.hashCode,
          title: 'Task Due: ${task.title}',
          body: task.description,
          scheduledDate: task.dueDate!,
        );
      }
    }
  }

  // Graph operations
  void addDependency(String fromId, String toId) {
    try {
      _graphService.addDependency(fromId, toId);
    } catch (e) {
      throw Exception('Failed to add dependency: $e');
    }
  }

  void removeDependency(String fromId, String toId) {
    try {
      _graphService.removeDependency(fromId, toId);
    } catch (e) {
      throw Exception('Failed to remove dependency: $e');
    }
  }

  List<String> getDependents(String id) {
    try {
      return _graphService.getDependents(id).toList();
    } catch (e) {
      throw Exception('Failed to get dependents: $e');
    }
  }

  List<String> getExecutionOrder() {
    try {
      return _graphService.getCompletionOrder();
    } catch (e) {
      throw Exception('Failed to get execution order: $e');
    }
  }

  bool hasDependents(String id) {
    return getDependents(id).isNotEmpty;
  }

  bool isDependencyValid(String fromId, String toId) {
    // Check if adding this dependency would create a cycle
    return !_graphService.isTaskDependentOn(fromId, toId);
  }
}
