import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestBookProvider =
    StateNotifierProvider<LatestBookNotifier, List<Book>>((ref) {
  return LatestBookNotifier();
});

class LatestBookNotifier extends StateNotifier<List<Book>> {
  LatestBookNotifier() : super([]);

  bool _isLoading = false;

  isLoading() => _isLoading;

  Future<void> latestBooks(int? categoryId) async {
    if (_isLoading) return;

    _isLoading = true;
    state = [];

    try {
      final books = await BookService().getLatestBooks(categoryId);
      if (books.isNotEmpty) state = books;
    } catch (e) {
      throw Exception('Failed to fetch latest books: $e');
    } finally {
      _isLoading = false;
    }
  }
}
