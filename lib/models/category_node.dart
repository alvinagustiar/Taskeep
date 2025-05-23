class CategoryNode {
  final String id;
  String name;
  CategoryNode? parent;
  final List<CategoryNode> children = [];

  CategoryNode({required this.id, required this.name, this.parent});

  /// Add a sub-category
  void addChild(CategoryNode child) {
    child.parent = this;
    children.add(child);
  }

  /// Remove a sub-category by id
  bool removeChildById(String childId) {
    for (var i = 0; i < children.length; i++) {
      if (children[i].id == childId) {
        children.removeAt(i);
        return true;
      }
      // Recursive removal
      if (children[i].removeChildById(childId)) {
        return true;
      }
    }
    return false;
  }

  /// Traverse tree and collect nodes
  List<CategoryNode> traverse() {
    List<CategoryNode> list = [this];
    for (var child in children) {
      list.addAll(child.traverse());
    }
    return list;
  }

  @override
  String toString() => 'CategoryNode(id: \$id, name: \$name)';
}
