class SubTaskNode {
  String id;
  String title;
  bool isCompleted;
  SubTaskNode? next;

  SubTaskNode({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.next,
  });

  // Add a new subtask node at the end
  void append(SubTaskNode newNode) {
    SubTaskNode current = this;
    while (current.next != null) {
      current = current.next!;
    }
    current.next = newNode;
  }

  // Remove a subtask by id
  SubTaskNode? remove(String nodeId) {
    if (id == nodeId) {
      return next;
    }
    SubTaskNode? current = this;
    while (current?.next != null) {
      if (current!.next!.id == nodeId) {
        current.next = current.next!.next;
        break;
      }
      current = current.next;
    }
    return this;
  }

  // Traverse and collect subtasks
  List<SubTaskNode> toList() {
    List<SubTaskNode> nodes = [];
    SubTaskNode? current = this;
    while (current != null) {
      nodes.add(current);
      current = current.next;
    }
    return nodes;
  }
}
