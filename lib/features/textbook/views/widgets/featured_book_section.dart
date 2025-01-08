import 'package:edu_app/features/textbook/controllers/categories_provider.dart';
import 'package:edu_app/features/textbook/controllers/feature_book_provider.dart';
import 'package:edu_app/features/textbook/views/widgets/book_card.dart';
import 'package:edu_app/features/textbook/views/widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedBookSection extends ConsumerStatefulWidget {
  const FeaturedBookSection({super.key});

  @override
  ConsumerState createState() => _FeaturedBookSectionState();
}

class _FeaturedBookSectionState extends ConsumerState<FeaturedBookSection> {
  int? _categoryId;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final featuredBooks = ref.watch(featuredBookProvider);
    final featuredNotifier = ref.read(featuredBookProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (featuredBooks.isEmpty) {
        featuredNotifier.featuredBooks(null);
      }
    });

    return Builder(
        builder: (context) => Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured Books',
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
                          featuredNotifier.featuredBooks(null);
                        }),
                        ...categories.map((category) => CategoryChip(
                                category.name, _categoryId == category.id, () {
                              setState(() {
                                _categoryId = category.id;
                              });
                              featuredNotifier.featuredBooks(category.id);
                            })),
                      ],
                    ),
                  ),
                ),
                Center(
                    child: featuredNotifier.isLoading()
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          )
                        : null),
                if (!featuredNotifier.isLoading() && featuredBooks.isEmpty)
                  Center(child: Text('No featured items')),
                if (featuredBooks.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: featuredBooks
                          .map((book) => BookCard(book, null))
                          .toList(),
                    ),
                  ),
              ],
            ));
  }
}
