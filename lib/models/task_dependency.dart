import 'dart:collection';

class TaskDependencyGraph {
  // Adjacency list representation
  final Map<String, Set<String>> _outgoingEdges = {};
  final Map<String, Set<String>> _incomingEdges = {};

  // Add a dependency: taskId depends on dependencyId
  void addDependency(String taskId, String dependencyId) {
    // Initialize sets if they don't exist
    _outgoingEdges.putIfAbsent(taskId, () => {});
    _incomingEdges.putIfAbsent(dependencyId, () => {});
    _outgoingEdges.putIfAbsent(dependencyId, () => {});
    _incomingEdges.putIfAbsent(taskId, () => {});

    // Add the dependency
    _outgoingEdges[dependencyId]!.add(taskId);
    _incomingEdges[taskId]!.add(dependencyId);
  }

  // Remove a dependency
  void removeDependency(String taskId, String dependencyId) {
    _outgoingEdges[dependencyId]?.remove(taskId);
    _incomingEdges[taskId]?.remove(dependencyId);
  }

  // Get all tasks that depend on the given task
  Set<String> getDependentTasks(String taskId) {
    return Set.from(_outgoingEdges[taskId] ?? {});
  }

  // Get all tasks that the given task depends on
  Set<String> getDependencies(String taskId) {
    return Set.from(_incomingEdges[taskId] ?? {});
  }

  // Remove a task and all its dependencies
  void removeTask(String taskId) {
    // Remove outgoing edges
    final dependentTasks = _outgoingEdges[taskId] ?? {};
    for (final dependentTask in dependentTasks) {
      _incomingEdges[dependentTask]?.remove(taskId);
    }
    _outgoingEdges.remove(taskId);

    // Remove incoming edges
    final dependencies = _incomingEdges[taskId] ?? {};
    for (final dependency in dependencies) {
      _outgoingEdges[dependency]?.remove(taskId);
    }
    _incomingEdges.remove(taskId);
  }

  // Check if adding a dependency would create a cycle
  bool wouldCreateCycle(String taskId, String dependencyId) {
    if (taskId == dependencyId) return true;

    Set<String> visited = {};
    Queue<String> queue = Queue<String>();
    queue.add(taskId);

    while (queue.isNotEmpty) {
      String current = queue.removeFirst();
      visited.add(current);

      for (String dependent in getDependentTasks(current)) {
        if (dependent == dependencyId) return true;
        if (!visited.contains(dependent)) {
          queue.add(dependent);
        }
      }
    }

    return false;
  }

  // Get tasks in topological order (for scheduling)
  List<String> getTopologicalOrder() {
    Map<String, int> inDegree = {};
    List<String> result = [];
    Queue<String> queue = Queue<String>();

    // Calculate in-degree for each task
    for (var entry in _incomingEdges.entries) {
      inDegree[entry.key] = entry.value.length;
    }

    // Add tasks with no dependencies to queue
    for (var taskId in _outgoingEdges.keys) {
      if (!inDegree.containsKey(taskId) || inDegree[taskId] == 0) {
        queue.add(taskId);
      }
    }

    // Process queue
    while (queue.isNotEmpty) {
      String taskId = queue.removeFirst();
      result.add(taskId);

      for (String dependent in getDependentTasks(taskId)) {
        inDegree[dependent] = (inDegree[dependent] ?? 0) - 1;
        if (inDegree[dependent] == 0) {
          queue.add(dependent);
        }
      }
    }

    return result;
  }

  // Get all tasks that must be completed before the given task
  Set<String> getAllPrerequisites(String taskId) {
    Set<String> prerequisites = {};
    Queue<String> queue = Queue<String>();
    queue.add(taskId);

    while (queue.isNotEmpty) {
      String current = queue.removeFirst();
      Set<String> dependencies = getDependencies(current);

      for (String dependency in dependencies) {
        if (prerequisites.add(dependency)) {
          queue.add(dependency);
        }
      }
    }

    return prerequisites;
  }

  // Get all tasks that depend on the given task (directly or indirectly)
  Set<String> getAllDependents(String taskId) {
    Set<String> dependents = {};
    Queue<String> queue = Queue<String>();
    queue.add(taskId);

    while (queue.isNotEmpty) {
      String current = queue.removeFirst();
      Set<String> currentDependents = getDependentTasks(current);

      for (String dependent in currentDependents) {
        if (dependents.add(dependent)) {
          queue.add(dependent);
        }
      }
    }

    return dependents;
  }

  // Check if all prerequisites of a task are completed
  bool canStart(String taskId, Set<String> completedTasks) {
    return getDependencies(taskId).every((dep) => completedTasks.contains(dep));
  }

  // Get next available tasks (tasks with all prerequisites completed)
  Set<String> getAvailableTasks(Set<String> completedTasks) {
    return _incomingEdges.keys
        .where(
          (taskId) =>
              !completedTasks.contains(taskId) &&
              canStart(taskId, completedTasks),
        )
        .toSet();
  }
}
