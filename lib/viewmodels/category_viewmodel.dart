import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../services/supabase_service.dart';

final categoryTreeProvider =
    StateProvider<CategoryTree>((ref) => CategoryTree());

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, List<Category>>((ref) {
  final supabase = SupabaseService();
  return CategoryViewModel(supabaseService: supabase);
});

class CategoryViewModel extends StateNotifier<List<Category>> {
  final SupabaseService supabaseService;
  final CategoryTree _categoryTree = CategoryTree();

  CategoryViewModel({required this.supabaseService}) : super([]) {
    _init();
  }

  Future<void> _init() async {
    await loadCategories();
    // Subscribe to real-time updates
    supabaseService.streamCategories().listen((categories) {
      state = categories;
      _updateCategoryTree(categories);
    });
  }

  void _updateCategoryTree(List<Category> categories) {
    _categoryTree.allCategories.clear();
    for (var category in categories) {
      _categoryTree.addCategory(category);
    }
  }

  // CRUD operations
  Future<void> loadCategories() async {
    try {
      final categories = await getCategories();
      state = categories;
      _updateCategoryTree(categories);
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await supabaseService
          .from('categories')
          .select()
          .eq('user_id', supabaseService.currentUser?.id);

      final categories = (response as List)
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .toList();

      return _buildCategoryTree(categories);
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<Category> createCategory(Category category) async {
    try {
      // Validate category before creation
      if (category.parentId != null) {
        _categoryTree.validateCategoryOperation(category);
      }

      final response = await supabaseService
          .from('categories')
          .insert({
            ...category.toJson(),
            'user_id': supabaseService.currentUser?.id,
          })
          .select()
          .single();

      final newCategory = Category.fromJson(response as Map<String, dynamic>);
      state = [...state, newCategory];
      _categoryTree.addCategory(newCategory);
      return newCategory;
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  Future<Category> updateCategory(Category category) async {
    try {
      // Validate category update
      _categoryTree.validateCategoryOperation(category);

      final response = await supabaseService
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id)
          .select()
          .single();

      final updatedCategory =
          Category.fromJson(response as Map<String, dynamic>);
      state = [
        for (final c in state)
          if (c.id == category.id) updatedCategory else c
      ];
      _categoryTree.updateCategory(updatedCategory);
      return updatedCategory;
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      // Get all descendant categories
      final descendants = _categoryTree.getAllDescendants(categoryId);
      final descendantIds = descendants.map((c) => c.id).toList();

      // Update all tasks in this category and its descendants to have no category
      await supabaseService.from('tasks').update({'category_id': null}).in_(
          'category_id', [categoryId, ...descendantIds]);

      // Delete all descendant categories
      if (descendantIds.isNotEmpty) {
        await supabaseService
            .from('categories')
            .delete()
            .in_('id', descendantIds);
      }

      // Delete the category itself
      await supabaseService.from('categories').delete().eq('id', categoryId);

      // Update local state
      state = state
          .where((c) => c.id != categoryId && !descendantIds.contains(c.id))
          .toList();
      _categoryTree.removeCategory(categoryId);
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  // Helper methods
  List<Category> _buildCategoryTree(List<Category> categories) {
    final Map<String?, List<Category>> categoryMap = {};

    // Group categories by parentId
    for (var category in categories) {
      categoryMap.putIfAbsent(category.parentId, () => []).add(category);
    }

    // Build tree recursively
    List<Category> buildTree(String? parentId) {
      final children = categoryMap[parentId] ?? [];
      return children.map((child) {
        final childrenIds =
            categoryMap[child.id]?.map((c) => c.id).toList() ?? [];
        return child.copyWith(childrenIds: childrenIds);
      }).toList();
    }

    return buildTree(null);
  }

  List<Category> getChildCategories(String parentId) {
    return _categoryTree.getChildren(parentId);
  }

  Category? getParentCategory(String categoryId) {
    final category = _categoryTree.getCategory(categoryId);
    if (category?.parentId == null) return null;
    return _categoryTree.getCategory(category!.parentId!);
  }

  List<Category> getAncestors(String categoryId) {
    return _categoryTree.getPath(categoryId);
  }

  bool isCategoryEmpty(String categoryId) {
    return state.firstWhere((c) => c.id == categoryId).taskCount == 0;
  }

  // Category tree access
  CategoryTree get categoryTree => _categoryTree;
}
