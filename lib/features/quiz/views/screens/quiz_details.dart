import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:edu_app/features/quiz/controllers/quiz_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class QuizDetails extends ConsumerWidget {
  final int quizId;
  const QuizDetails(this.quizId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider)?['user'];
    final quizDetails = ref.watch(quizDetailsProvider);
    final QuizDetailsNotifier quizDetailsNotifier =
        ref.read(quizDetailsProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (quizDetails == null) {
        quizDetailsNotifier.fetchQuiz(quizId);
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
              children: [_quizDetails(quizDetails)]),
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

  Widget _quizDetails(quizDetails) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        int questionId = index + 1;
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
                    Text("What is the capital of France?"),
                    Row(
                      children: [
                        Radio<String>(
                          value: "Paris",
                          groupValue: _selectedAnswer[questionId],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswer[questionId] = value;
                            });
                          },
                        ),
                        Text("Paris"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: "London",
                          groupValue: _selectedAnswer[questionId],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswer[questionId] = value;
                            });
                          },
                        ),
                        Text("London"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: "Berlin",
                          groupValue: _selectedAnswer[questionId],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswer[questionId] = value;
                            });
                          },
                        ),
                        Text("Berlin"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: "Madrid",
                          groupValue: _selectedAnswer[questionId],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswer[questionId] = value;
                            });
                          },
                        ),
                        Text("Madrid"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
