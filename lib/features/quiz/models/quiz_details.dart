import 'package:edu_app/features/quiz/models/question.dart';

class QuizDetailsModel {
  int id;
  String title;
  String description;
  String userName;
  String createdAt;
  List<Question> questions;

  QuizDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userName,
    required this.createdAt,
    required this.questions,
  });

  factory QuizDetailsModel.fromJson(Map<String, dynamic> json) {
    return QuizDetailsModel(
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
