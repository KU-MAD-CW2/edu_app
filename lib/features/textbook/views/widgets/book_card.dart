import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookCard extends ConsumerWidget {
  final Book book;
  final double? scale;

  const BookCard(this.book, this.scale, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = dotenv.get('IMAGE_URL');

    double? scalePercentage = scale ?? 0.38;
    double width = (MediaQuery.of(context).size.width * scalePercentage);

    return GestureDetector(
      onTap: () {
        context.pushNamed(bookDetailRoute.name as String, extra: book);
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl + book.cover_image,
                height: width * 1.28,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "by ${book.user?.name}",
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
