import 'package:edu_app/features/textbook/controllers/categories_provider.dart';
import 'package:edu_app/features/textbook/controllers/latest_book_provider.dart';
import 'package:edu_app/features/textbook/views/widgets/book_card.dart';
import 'package:edu_app/features/textbook/views/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestBookSection extends ConsumerStatefulWidget {
  const LatestBookSection({super.key});

  @override
  ConsumerState createState() => _LatestBookSectionState();
}

class _LatestBookSectionState extends ConsumerState<LatestBookSection> {
  int? _categoryId;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final categoriesNotifier = ref.read(categoriesProvider.notifier);
    final latestBooks = ref.watch(latestBookProvider);
    final latestNotifier = ref.read(latestBookProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categories.isEmpty) {
        categoriesNotifier.getCategories();
      }

      if (latestBooks.isEmpty) {
        latestNotifier.latestBooks(null);
      }
    });

    return Builder(
        builder: (context) => Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrivals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: [
                        CategoryChip('All', _categoryId == null, () {
                          setState(() {
                            _categoryId = null;
                          });
                          latestNotifier.latestBooks(null);
                        }),
                        ...categories.map((category) => CategoryChip(
                                category.name, category.id == _categoryId, () {
                              setState(() {
                                _categoryId = category.id;
                              });
                              latestNotifier.latestBooks(category.id);
                            })),
                      ],
                    ),
                  ),
                ),
                Center(
                    child: latestNotifier.isLoading()
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          )
                        : null),
                if (!latestNotifier.isLoading() && latestBooks.isEmpty)
                  Center(child: Text('No latest books found')),
                if (latestBooks.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: latestBooks
                          .map((book) => BookCard(
                                book.title,
                                book.user!.name,
                                book.cover_image,
                              ))
                          .toList(),
                    ),
                  ),
              ],
            ));
  }
}
