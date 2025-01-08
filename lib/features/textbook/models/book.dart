import 'package:edu_app/features/auth/models/user.dart';
import 'package:edu_app/features/textbook/models/category.dart';
import 'package:edu_app/features/textbook/models/chapter.dart';

class Book {
  int id;
  String title;
  String slug;
  String cover_image;
  User? user;
  List<Category> categories = [];
  List<Chapter> chapters = [];

  Book({
    required this.id,
    required this.title,
    required this.slug,
    required this.cover_image,
    this.user,
    this.categories = const [],
    this.chapters = const [],
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    List<Category> mapCategories(Map<String, dynamic> map) {
      if (!map.containsKey('categories')) return [];
      final categories = map['categories'] as List<dynamic>;
      return categories.isNotEmpty
          ? List<dynamic>.from(map['categories'])
              .map((category) => Category.fromJson(category))
              .toList()
          : [];
    }

    return Book(
      id: map['id'],
      title: map['title'],
      slug: map['slug'],
      cover_image: map['cover_image'],
      user: map['user'] != null ? User.fromJson(map['user']) : null,
      categories: mapCategories(map),
      chapters: map.containsKey('chapters') &&
              List<dynamic>.from(map['chapters']).isNotEmpty
          ? List<Chapter>.from(
              map['chapters'].map((chapter) => Chapter.fromJson(chapter)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'cover_image': cover_image,
      'user': user?.toJson(),
      'chapters': chapters.map((chapter) => chapter.toMap()).toList(),
    };
  }
}
