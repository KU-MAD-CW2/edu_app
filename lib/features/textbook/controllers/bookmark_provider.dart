import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/book.dart';

final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, List<Book>>((ref) {
  return BookmarkNotifier();
});

class BookmarkNotifier extends StateNotifier<List<Book>> {
  BookmarkNotifier() : super([]);

  void removeBook(Book book) {
    state = state.where((b) => b.id != book.id).toList();
  }

  void addBook(Book book) {
    state = [...state, book];
  }
}
