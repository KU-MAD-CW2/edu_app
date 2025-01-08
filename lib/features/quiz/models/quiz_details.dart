import 'package:edu_app/features/quiz/models/question.dart';

class QuizDetails {
  int id;
  String title;
  String description;
  String userName;
  String createdAt;
  List<Question> questions;

  QuizDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.userName,
    required this.createdAt,
    required this.questions,
  });

  factory QuizDetails.fromJson(Map<String, dynamic> json) {
    return QuizDetails(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userName: json['userName'],
      createdAt: json['createdAt'],
      questions: List<Question>.from(
        json['questions'].map((x) => Question.fromJson(x)),
      ),
    );
  }
}
