import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:edu_app/features/quiz/controllers/quiz_details_provider.dart';
import 'package:edu_app/features/quiz/models/answer.dart';
import 'package:edu_app/features/quiz/models/quiz_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_app/features/quiz/models/question.dart';
import 'package:edu_app/common/fields/primary_button.dart';
import 'package:edu_app/features/quiz/views/widgets/app_bar_widget.dart';

class QuizDetails extends ConsumerStatefulWidget {
  final int quizId;
  const QuizDetails(this.quizId, {super.key});

  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends ConsumerState<QuizDetails> {
  final Map<int, String> _selectedAnswer = {};

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider)?['user'];
    final quizDetails = ref.watch(quizDetailsProvider);
    final QuizDetailsNotifier quizDetailsNotifier =
        ref.read(quizDetailsProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ((quizDetails != null && quizDetails.id != widget.quizId) ||
          quizDetails == null) {
        quizDetailsNotifier.fetchQuiz(widget.quizId);
      }
    });

    return AppSafeArea(
        child: Scaffold(
      appBar: AppBarWidget(user.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: quizDetailsNotifier.isLoading()
                  ? [
                      const Center(
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Loading details...',
                        ),
                      )
                    ]
                  : [
                      quizDetails == null
                          ? const SizedBox.shrink()
                          : _quizDetails(quizDetails)
                    ]),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 1),
    ));
  }

  Widget _quizDetails(QuizDetailsModel quizDetails) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: quizDetails.questions.length,
          itemBuilder: (context, index) {
            int questionId = index + 1;
            Question question = quizDetails.questions[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(question.question),
                        ...question.answers.map((answer) {
                          return Row(
                            children: [
                              Radio<String>(
                                value: answer.id.toString(),
                                groupValue: _selectedAnswer[questionId],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswer[questionId] = value ?? "";
                                  });
                                },
                              ),
                              Text(answer.answer),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 8),
        PrimaryButton("Show Results", onPressed: () {
          int correctAnswers = 0;
          for (int i = 0; i < quizDetails.questions.length; i++) {
            Question question = quizDetails.questions[i];
            Answer correctAnswer =
                question.answers.firstWhere((answer) => answer.isCorrect);
            if (_selectedAnswer[i + 1] == correctAnswer.id.toString()) {
              correctAnswers++;
            }
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Your Score"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "You scored $correctAnswers out of ${quizDetails.questions.length} marks"),
                      SizedBox(height: 16),
                      ...quizDetails.questions.map((question) {
                        int questionId =
                            quizDetails.questions.indexOf(question) + 1;
                        Answer correctAnswer = question.answers
                            .firstWhere((answer) => answer.isCorrect);
                        bool isCorrect = _selectedAnswer[questionId] ==
                            correctAnswer.id.toString();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(question.question),
                            Text(
                                "Your answer: ${_selectedAnswer[questionId] != null ? question.answers.firstWhere((answer) => answer.id.toString() == _selectedAnswer[questionId]).answer : "Not answered"}"),
                            Text("Correct answer: ${correctAnswer.answer}"),
                            Text(isCorrect ? "Correct" : "Incorrect",
                                style: TextStyle(
                                    color:
                                        isCorrect ? Colors.green : Colors.red)),
                            SizedBox(height: 16),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
