class Section {
  int id;
  String title;
  String content;

  Section({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
