class Quiz {
  int id;
  String title;
  String description;
  String language;
  String status;
  String userName;
  String createdAt;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.status,
    required this.userName,
    required this.createdAt,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      language: json["language"],
      status: json["status"],
      userName: json["userName"],
      createdAt: json["createdAt"],
    );
  }

  @override
  String toString() {
    return 'Quiz{id: $id, title: $title, description: $description, language: $language, status: $status, userName: $userName, createdAt: $createdAt}';
  }
}