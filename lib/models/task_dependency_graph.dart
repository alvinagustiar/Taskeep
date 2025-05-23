import 'package:collection/collection.dart';

class TaskDependencyGraph {
  // Adjacency list representation
  final Map<String, Set<String>> _dependencies = {};
  final Map<String, Set<String>> _dependents = {};

  // Add a dependency: task1 depends on task2
  void addDependency(String task1Id, String task2Id) {
    _dependencies.putIfAbsent(task1Id, () => {}).add(task2Id);
    _dependents.putIfAbsent(task2Id, () => {}).add(task1Id);
  }

  // Remove a dependency
  void removeDependency(String task1Id, String task2Id) {
    _dependencies[task1Id]?.remove(task2Id);
    _dependents[task2Id]?.remove(task1Id);

    // Clean up empty sets
    if (_dependencies[task1Id]?.isEmpty ?? false) {
      _dependencies.remove(task1Id);
    }
    if (_dependents[task2Id]?.isEmpty ?? false) {
      _dependents.remove(task2Id);
    }
  }

  // Get all tasks that this task depends on
  Set<String> getDependencies(String taskId) {
    return _dependencies[taskId] ?? {};
  }

  // Get all tasks that depend on this task
  Set<String> getDependents(String taskId) {
    return _dependents[taskId] ?? {};
  }

  // Check if completing taskId would create a cycle
  bool wouldCreateCycle(String taskId) {
    final visited = <String>{};
    final recursionStack = <String>{};

    bool hasCycle(String currentId) {
      if (recursionStack.contains(currentId)) return true;
      if (visited.contains(currentId)) return false;

      visited.add(currentId);
      recursionStack.add(currentId);

      final dependencies = getDependencies(currentId);
      for (final depId in dependencies) {
        if (hasCycle(depId)) return true;
      }

      recursionStack.remove(currentId);
      return false;
    }

    return hasCycle(taskId);
  }

  // Get tasks in order they can be completed (topological sort)
  List<String> getCompletionOrder() {
    final result = <String>[];
    final visited = <String>{};

    void visit(String taskId) {
      if (visited.contains(taskId)) return;
      visited.add(taskId);

      for (final depId in getDependencies(taskId)) {
        visit(depId);
      }
      result.add(taskId);
    }

    // Start with tasks that have no dependents (leaf nodes)
    final allTasks = {..._dependencies.keys, ..._dependents.keys};
    for (final taskId in allTasks) {
      if (getDependents(taskId).isEmpty) {
        visit(taskId);
      }
    }

    return result.reversed.toList();
  }

  // Remove a task and all its dependencies
  void removeTask(String taskId) {
    // Remove task as a dependent from all its dependencies
    for (final depId in getDependencies(taskId)) {
      _dependents[depId]?.remove(taskId);
      if (_dependents[depId]?.isEmpty ?? false) {
        _dependents.remove(depId);
      }
    }

    // Remove task as a dependency from all its dependents
    for (final depId in getDependents(taskId)) {
      _dependencies[depId]?.remove(taskId);
      if (_dependencies[depId]?.isEmpty ?? false) {
        _dependencies.remove(depId);
      }
    }

    // Remove the task's own entries
    _dependencies.remove(taskId);
    _dependents.remove(taskId);
  }

  // Clear all dependencies
  void clear() {
    _dependencies.clear();
    _dependents.clear();
  }

  // Check if task1 depends on task2 (directly or indirectly)
  bool isDependentOn(String task1Id, String task2Id) {
    final visited = <String>{};

    bool dfs(String currentId) {
      if (currentId == task2Id) return true;
      if (visited.contains(currentId)) return false;

      visited.add(currentId);
      final dependencies = getDependencies(currentId);

      return dependencies.any(dfs);
    }

    return dfs(task1Id);
  }
}
