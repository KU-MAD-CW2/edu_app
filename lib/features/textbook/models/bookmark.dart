import 'package:jiffy/jiffy.dart';

class Bookmark {
  int? id;
  final int bookId;
  final String content;
  final String createdAt;

  Bookmark({
    required this.bookId,
    required this.content,
    required this.createdAt,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      bookId: json['book_id'],
      content: json['content'],
      createdAt: json['created_at'] ??
          Jiffy.now().format(pattern: 'yyyy-MM-dd HH:mm:ss'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'content': content,
      'created_at': createdAt,
    };
  }
}
