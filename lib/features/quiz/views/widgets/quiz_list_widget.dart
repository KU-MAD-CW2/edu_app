import 'package:edu_app/features/quiz/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/app/routes/routes.dart';
import 'package:go_router/go_router.dart';

class QuizListWidget extends StatelessWidget {
  final List<Quiz> quizzes;
  const QuizListWidget(this.quizzes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.red.shade50,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Text(quizzes[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(quizzes[index].description),
                Text(
                  'Name: ${quizzes[index].userName}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Date: ${quizzes[index].createdAt}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            onTap: () {
              context.goNamed(quizDetails.name as String,
                  extra: quizzes[index].id);
            },
          ),
        );
      },
    );
  }
}
