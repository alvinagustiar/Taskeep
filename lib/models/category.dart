import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String? parentId,
    @Default([]) List<String> childrenIds,
    @Default(0) int taskCount,
    String? color,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

class CategoryTree {
  final Map<String, Category> _nodes = {};
  String? _rootId;

  void addCategory(Category category) {
    _nodes[category.id] = category;
    if (category.parentId == null) {
      _rootId = category.id;
    }
  }

  Category? getCategory(String id) => _nodes[id];

  List<Category> getChildren(String parentId) {
    return _nodes.values
        .where((category) => category.parentId == parentId)
        .toList();
  }

  List<Category> getAllDescendants(String parentId) {
    List<Category> descendants = [];
    List<Category> children = getChildren(parentId);

    for (var child in children) {
      descendants.add(child);
      descendants.addAll(getAllDescendants(child.id));
    }

    return descendants;
  }

  Category? get root => _rootId != null ? _nodes[_rootId] : null;

  List<Category> get allCategories => _nodes.values.toList();

  void removeCategory(String id) {
    if (_nodes.containsKey(id)) {
      // Get all descendants
      final descendants = getAllDescendants(id);

      // Remove all descendants
      for (var descendant in descendants) {
        _nodes.remove(descendant.id);
      }

      // Remove the category itself
      _nodes.remove(id);

      // If we removed the root, find a new root
      if (id == _rootId) {
        _rootId = _nodes.values
            .firstWhere(
              (category) => category.parentId == null,
              orElse: () =>
                  throw Exception('No root category found after deletion'),
            )
            .id;
      }

      // Update parent's children list
      final parent = _nodes.values.firstWhere(
        (category) => category.childrenIds.contains(id),
        orElse: () => _nodes.values.first,
      );
      if (parent.childrenIds.contains(id)) {
        _nodes[parent.id] = parent.copyWith(
          childrenIds: [...parent.childrenIds]..remove(id),
        );
      }
    }
  }

  void updateCategory(Category category) {
    if (_nodes.containsKey(category.id)) {
      final oldCategory = _nodes[category.id]!;

      // If parent changed, update old and new parent's children lists
      if (oldCategory.parentId != category.parentId) {
        // Remove from old parent's children
        if (oldCategory.parentId != null) {
          final oldParent = _nodes[oldCategory.parentId];
          if (oldParent != null) {
            _nodes[oldParent.id] = oldParent.copyWith(
              childrenIds: [...oldParent.childrenIds]..remove(category.id),
            );
          }
        }

        // Add to new parent's children
        if (category.parentId != null) {
          final newParent = _nodes[category.parentId];
          if (newParent != null) {
            _nodes[newParent.id] = newParent.copyWith(
              childrenIds: [...newParent.childrenIds, category.id],
            );
          }
        }
      }

      _nodes[category.id] = category;
    }
  }

  List<Category> getPath(String categoryId) {
    List<Category> path = [];
    Category? current = getCategory(categoryId);

    while (current != null) {
      path.insert(0, current);
      current =
          current.parentId != null ? getCategory(current.parentId!) : null;
    }

    return path;
  }

  bool isCyclic(String categoryId, String newParentId) {
    // Check if the new parent is a descendant of the category
    return getAllDescendants(categoryId).any((desc) => desc.id == newParentId);
  }

  void validateCategoryOperation(Category category) {
    // Check for cycles when updating parent
    if (category.parentId != null &&
        isCyclic(category.id, category.parentId!)) {
      throw Exception('Cannot create cyclic category relationship');
    }

    // Validate parent exists if specified
    if (category.parentId != null && !_nodes.containsKey(category.parentId)) {
      throw Exception('Parent category does not exist');
    }
  }
}
