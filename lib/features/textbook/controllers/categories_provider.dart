import 'package:edu_app/features/textbook/models/category.dart';
import 'package:edu_app/utils/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) {
  return CategoriesNotifier();
});

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);

  bool _isLoading = false;

  isLoading() => _isLoading;

  Future<void> getCategories() async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final response = await Request().get('/categories?has_books=true',
          headers: {'Content-Type': 'application/json'}) as List;
      final categories =
          response.map((json) => Category.fromJson(json)).toList();
      if (categories.isNotEmpty) state = List.from(state)..addAll(categories);
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    } finally {
      _isLoading = false;
    }
  }
}
