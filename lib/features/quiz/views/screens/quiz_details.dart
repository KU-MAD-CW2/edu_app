import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:edu_app/features/quiz/controllers/quiz_details_provider.dart';
import 'package:edu_app/features/quiz/models/quiz_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:edu_app/features/quiz/models/question.dart';
import 'package:edu_app/common/fields/primary_button.dart';

class QuizDetails extends ConsumerStatefulWidget {
  final int quizId;
  const QuizDetails(this.quizId, {super.key});

  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends ConsumerState<QuizDetails> {
  Map<int, String> _selectedAnswer = {};

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
      appBar: _buildAppBar(user.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: quizDetailsNotifier.isLoading()
                  ? [
                      const Center(
                        child: CircularProgressIndicator(),
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

  AppBar _buildAppBar(String name) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $name!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    "Let’s start reading",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
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
                                value: answer.answer,
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
        PrimaryButton("Show Results", onPressed: () => {}),
      ],
    );
  }
}
