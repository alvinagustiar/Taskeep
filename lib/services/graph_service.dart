import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_dependency_graph.dart';
import '../models/task.dart';

final graphServiceProvider = Provider<GraphService>((ref) {
  return GraphService();
});

class GraphService {
  final TaskDependencyGraph _graph = TaskDependencyGraph();

  // Add a dependency between tasks
  void addDependency(String dependentTaskId, String dependencyTaskId) {
    if (!_graph.wouldCreateCycle(dependentTaskId)) {
      _graph.addDependency(dependentTaskId, dependencyTaskId);
    } else {
      throw Exception('Adding this dependency would create a cycle');
    }
  }

  // Remove a dependency between tasks
  void removeDependency(String dependentTaskId, String dependencyTaskId) {
    _graph.removeDependency(dependentTaskId, dependencyTaskId);
  }

  // Get all tasks that this task depends on
  Set<String> getDependencies(String taskId) {
    return _graph.getDependencies(taskId);
  }

  // Get all tasks that depend on this task
  Set<String> getDependents(String taskId) {
    return _graph.getDependents(taskId);
  }

  // Get tasks in order they can be completed
  List<String> getCompletionOrder() {
    return _graph.getCompletionOrder();
  }

  // Check if task1 depends on task2 (directly or indirectly)
  bool isTaskDependentOn(String task1Id, String task2Id) {
    return _graph.isDependentOn(task1Id, task2Id);
  }

  // Remove a task and all its dependencies
  void removeTask(String taskId) {
    _graph.removeTask(taskId);
  }

  // Clear all dependencies
  void clear() {
    _graph.clear();
  }

  // Validate a list of tasks for circular dependencies
  bool validateTaskList(List<Task> tasks) {
    for (final task in tasks) {
      if (_graph.wouldCreateCycle(task.id)) {
        return false;
      }
    }
    return true;
  }

  // Get all tasks that must be completed before this task
  Set<String> getPrerequisiteTasks(String taskId) {
    final prerequisites = <String>{};
    void traverse(String currentId) {
      final dependencies = getDependencies(currentId);
      for (final depId in dependencies) {
        if (!prerequisites.contains(depId)) {
          prerequisites.add(depId);
          traverse(depId);
        }
      }
    }

    traverse(taskId);
    return prerequisites;
  }

  // Get all tasks that can only be started after this task
  Set<String> getBlockedTasks(String taskId) {
    final blocked = <String>{};
    void traverse(String currentId) {
      final dependents = getDependents(currentId);
      for (final depId in dependents) {
        if (!blocked.contains(depId)) {
          blocked.add(depId);
          traverse(depId);
        }
      }
    }

    traverse(taskId);
    return blocked;
  }
}
