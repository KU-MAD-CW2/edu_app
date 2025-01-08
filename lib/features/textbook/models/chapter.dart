import 'package:edu_app/features/textbook/models/section.dart';

class Chapter {
  int id;
  String title;
  List<Section> sections;

  Chapter({
    required this.id,
    required this.title,
    required this.sections,
  });

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'],
      title: map['title'],
      sections: List<Section>.from(
        map['sections'].map((section) => Section.fromMap(section)),
      ),
    );
  }

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      title: json['title'],
      sections: List<Section>.from(
        json['sections'].map((section) => Section.fromMap(section)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'sections': sections.map((section) => section.toMap()).toList(),
    };
  }
}
