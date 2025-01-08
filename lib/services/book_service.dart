import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/utils/request.dart';

class BookService {
  Future<List<Book>> getLatestBooks(int? categoryId) async {
    try {
      String path = '/search-books';
      if (categoryId != null) path += '?categories[]=$categoryId';
      final response = await Request().get(path);
      final data = response['data'] as List;
      return data.map((json) => Book.fromMap(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch latest books: $e');
    }
  }

  Future<List<Book>> getFeaturedBooks(int? categoryId) async {
    try {
      String path = '/search-books?featured=true';
      if (categoryId != null) path += '&categories[]=$categoryId';
      final response = await Request().get(path);
      final data = response['data'] as List;
      return data.map((json) => Book.fromMap(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch featured books: $e');
    }
  }

  Future<Book> getBook(int bookId) async {
    try {
      final response = await Request().get('/books/$bookId');
      return Book.fromMap(response['data']);
    } catch (e) {
      throw Exception('Failed to fetch book: $e');
    }
  }
}
