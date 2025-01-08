import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/textbook/controllers/book_detail_provider.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/features/textbook/views/widgets/about_book.dart';
import 'package:edu_app/features/textbook/views/widgets/book_chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends ConsumerWidget {
  final Book book;

  const BookDetailsScreen(this.book, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookItem = ref.watch(bookDetailProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (bookItem == null) {
        ref.read(bookDetailProvider.notifier).getBook(book.id);
      }
    });

    return AppSafeArea(
        appBarColor: Colors.grey.shade100,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBookCover(context, book.cover_image),
                    SizedBox(height: 125),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          _buildBookTitle(context, book),
                          SizedBox(height: 24),
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  labelColor: Theme.of(context).primaryColor,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor:
                                      Theme.of(context).primaryColor,
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  tabs: [
                                    Tab(text: 'About'),
                                    Tab(text: 'Chapters'),
                                    // Tab(text: 'Reviews'),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: TabBarView(
                                    children: [
                                      AboutBook(book),
                                      bookItem != null
                                          ? BookChapters(bookItem)
                                          : BookChapters(book), // Placeholder
                                      // Center(
                                      //     child:
                                      //         Text('Reviews')), // Placeholder
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Center _buildBookTitle(BuildContext context, Book book) {
    return Center(
      child: Column(
        children: [
          Text(book.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                book.user!.name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.verified,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack _buildBookCover(BuildContext context, String coverImage) {
    String pathPrefix = dotenv.get('IMAGE_URL');
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          color: Colors.grey.shade100,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.25,
          child: Container(
            height: MediaQuery.of(context).size.width * 0.65,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(pathPrefix + coverImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Book Details',
          style: Theme.of(context).textTheme.headlineMedium),
      centerTitle: true,
      backgroundColor: Colors.grey.shade100,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => context.goNamed(homeRoute.name as String),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {},
        ),
      ],
    );
  }
}
