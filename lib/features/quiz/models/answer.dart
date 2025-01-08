class Answer {
  int id;
  String answer;
  bool isCorrect;

  Answer({
    required this.id,
    required this.answer,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      answer: json['answer'],
      isCorrect: json['isCorrect'],
    );
  }
}
