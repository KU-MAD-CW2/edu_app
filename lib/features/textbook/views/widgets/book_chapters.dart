import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookChapters extends ConsumerWidget {
  final Book book;
  const BookChapters(this.book, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Chapters (${book.chapters.length})',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: book.chapters
                .length, // Replace with dynamic count from your data source
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text('${index + 1}',
                          style: TextStyle(color: Colors.white)),
                    ),
                    title: Text(
                      book.chapters[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Chapter ${index + 1}'),
                    onTap: index == 0
                        ? () {
                            context.pushNamed(chapterDetailRoute.name as String,
                                extra: {
                                  'book': book,
                                  'chapter': book.chapters[index],
                                });
                          }
                        : null,
                  ),
                ),
              );
            },
          ))
        ]),
      );
    });
  }
}
