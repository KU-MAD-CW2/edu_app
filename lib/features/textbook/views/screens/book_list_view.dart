import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/textbook/controllers/search_books_provider.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/features/textbook/views/widgets/book_card.dart';
import 'package:edu_app/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookListView extends ConsumerStatefulWidget {
  const BookListView({super.key});

  @override
  _BookListViewState createState() => _BookListViewState();
}

class _BookListViewState extends ConsumerState<BookListView> {
  String sortBy = "publishedAt";
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  final debouncer = Debouncer(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchBookProvider);
    final searchNotifier = ref.watch(searchBookProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (searchResults.isEmpty) {
        searchNotifier.searchNews();
      }
    });

    return AppSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const Text('Library'),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              searchNotifier.searchNextPage();
            }
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildSearchBar(searchNotifier),
                const SizedBox(height: 16),
                _buildSearchResults(searchResults, searchNotifier)
              ],
            ),
          )),
      bottomNavigationBar: AppNavigationBar(currentIndex: 3),
    ));
  }

  Widget _buildSearchBar(SearchNotifier searchNotifier) {
    return Builder(builder: (context) {
      return TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: (value) async {
          debouncer.run(() {
            searchNotifier.setSearchTerm(value);
          });
          if (value.isEmpty) {
            FocusScope.of(context).unfocus();
            searchNotifier.setHideShowSearch();
            searchNotifier.resetData();
          }
        },
        decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: searchNotifier.term.isEmpty
              ? const Icon(Icons.search)
              : InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    searchNotifier.resetData();
                    searchNotifier.setHideShowSearch();
                    searchNotifier.setSearchEmpty();
                    controller.clear();
                  },
                  child: const Icon(Icons.close_rounded),
                ),
          border: _buildInputBorder(),
          enabledBorder: _buildInputBorder(),
          focusedBorder: _buildInputBorder(width: 2.0),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      );
    });
  }

  Widget _buildSearchResults(
      List<Book> searchResults, SearchNotifier searchNotifier) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (searchNotifier.term.isEmpty) const Text('All books'),
              if (searchNotifier.term.isNotEmpty)
                Wrap(
                  children: [
                    const Text('Showing results for '),
                    Text(searchNotifier.term,
                        style: const TextStyle(fontWeight: FontWeight.w600))
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: searchNotifier.isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return BookCard(searchResults[index], 0.4);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildInputBorder({double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey.shade300, width: width),
    );
  }
}
