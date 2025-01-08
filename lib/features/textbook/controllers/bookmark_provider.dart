import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/book.dart';

final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, List<Book>>((ref) {
  return BookmarkNotifier();
});

class BookmarkNotifier extends StateNotifier<List<Book>> {
  BookmarkNotifier() : super([]) {
    loadBookmarks();
  }

  void removeBook(Book book) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getStringList('bookmarks');
    if (data != null) {
      data.remove(jsonEncode(book.toMap()));
      await sharedPreferences.setStringList('bookmarks', data);
    }
    loadBookmarks();
  }

  void addBook(Book book) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getStringList('bookmarks');
    if (data == null) {
      await sharedPreferences
          .setStringList('bookmarks', [jsonEncode(book.toMap())]);
    }
    if (data != null) {
      data.add(jsonEncode(book.toMap()));
      await sharedPreferences.setStringList('bookmarks', data);
    }

    loadBookmarks();
  }

  bool isBookmarked(Book book) {
    for (var element in state) {
      if (element.id == book.id) {
        return true;
      }
    }
    return false;
  }

  void loadBookmarks() async {
    List<Book> books = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getStringList('bookmarks');
    if (data != null) {
      for (var item in data) {
        final book = Book.fromMap(jsonDecode(item));
        books.add(book);
      }
    }
    print(books);
    state = books;
  }
}
