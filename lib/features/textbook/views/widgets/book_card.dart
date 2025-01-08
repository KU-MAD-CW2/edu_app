import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookCard extends ConsumerWidget {
  final String imagePath;
  final String title;
  final String author;

  const BookCard(this.title, this.author, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = dotenv.get('IMAGE_URL');

    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl + imagePath,
              height: 180,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "by $author",
            style: TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
