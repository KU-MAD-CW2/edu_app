import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/textbook/controllers/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookmarkList extends ConsumerStatefulWidget {
  const BookmarkList({super.key});

  @override
  _BookmarkListState createState() => _BookmarkListState();
}

class _BookmarkListState extends ConsumerState<BookmarkList> {
  @override
  Widget build(BuildContext context) {
    final bookMarks = ref.watch(bookmarkProvider);
    final bookmarksNotifier = ref.watch(bookmarkProvider.notifier);

    return AppSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Bookmark'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Total book saved',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text('${bookMarks.length} items'),
                ),
              ],
            ),
          ),
          if (bookMarks.isEmpty)
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No book saved yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: bookMarks.length,
              itemBuilder: (context, index) {
                final book = bookMarks[index];
                String pathPrefix = dotenv.get('IMAGE_URL');
                return GestureDetector(
                  onTap: () {
                    context.goNamed(bookDetailRoute.name as String,
                        extra: book);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: Image.network(
                        pathPrefix + book.cover_image,
                      ),
                      title: Text(book.title,
                          style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(book.user!.name),
                      trailing: IconButton(
                        icon: Icon(Icons.bookmark,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {
                          bookmarksNotifier.removeBook(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${book.title} removed from bookmark'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 3),
    ));
  }
}
