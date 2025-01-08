import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/utils/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookDetailProvider =
    StateNotifierProvider<BookDetailNotifier, Book?>((ref) {
  return BookDetailNotifier();
});

class BookDetailNotifier extends StateNotifier<Book?> {
  BookDetailNotifier() : super(null);

  bool _isLoading = false;

  isLoading() => _isLoading;

  Future<void> getBook(int bookId) async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final response = await Request().get('/books/$bookId');
      state = Book.fromMap(response);
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    } finally {
      _isLoading = false;
    }
  }
}
