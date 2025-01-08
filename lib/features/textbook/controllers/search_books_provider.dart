import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchBookProvider =
    StateNotifierProvider<SearchNotifier, List<Book>>((ref) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<List<Book>> {
  SearchNotifier() : super([]);

  int pageNumber = 1;
  bool isLoading = false;
  bool dataEmpty = false;
  bool showSearch = false;
  String term = "";
  String sortBy = "publishedAt";

  Future<void> setSortBy(String value) async {
    sortBy = value;
    await searchNews();
  }

  void setSearchTerm(String keyword) async {
    term = keyword;
    await searchNews();
  }

  void setSearchEmpty() async {
    term = "";
    resetData();
  }

  void resetData() {
    state = [];
    pageNumber = 1;
  }

  void setHideShowSearch() async {
    showSearch = false;
  }

  void setShowSearch() async {
    showSearch = true;
  }

  Future<void> searchNews() async {
    resetData();
    await searchNextPage();
  }

  Future<void> searchNextPage() async {
    if (isLoading) return;
    isLoading = true;
    dataEmpty = false;

    try {
      final data = await BookService()
          .search(search: term, page: pageNumber, sortBy: sortBy);
      if (data.isNotEmpty) {
        state = List.from(state)..addAll(data);
        pageNumber++;
      } else {
        isLoading = false;
        dataEmpty = true;
      }
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      isLoading = false;
    }
  }
}
