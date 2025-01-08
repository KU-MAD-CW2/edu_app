import 'package:edu_app/features/quiz/models/answer.dart';

class Question {
  int id;
  String question;
  List<Answer> answers;

  Question({
    required this.id,
    required this.question,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      answers: List<Answer>.from(
        json['answers'].map((x) => Answer.fromJson(x)),
      ),
    );
  }
}