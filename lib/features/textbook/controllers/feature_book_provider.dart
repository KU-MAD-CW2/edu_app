import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final featuredBookProvider =
    StateNotifierProvider<FeaturedNotifier, List<Book>>((ref) {
  return FeaturedNotifier();
});

class FeaturedNotifier extends StateNotifier<List<Book>> {
  FeaturedNotifier() : super([]);

  bool _isLoading = false;

  bool isLoading() => _isLoading;

  Future<void> featuredBooks(int? categoryId) async {
    if (_isLoading) return;

    _isLoading = true;
    state = [];

    try {
      List<Book> response = await BookService().getFeaturedBooks(categoryId);
      state = response;
    } catch (e) {
      throw Exception('Failed to fetch featured books: $e');
    } finally {
      _isLoading = false;
    }
  }
}
