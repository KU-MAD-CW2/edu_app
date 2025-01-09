import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/quiz/views/widgets/quiz_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:edu_app/features/quiz/controllers/quiz_provider.dart';

class QuizList extends ConsumerWidget {
  const QuizList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider)?['user'];

    final quizzes = ref.watch(quizNotifierProvider);
    final QuizNotifier quizNotifier = ref.read(quizNotifierProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (quizzes.isEmpty) {
        quizNotifier.fetchQuizzes();
      }
    });

    return AppSafeArea(
        child: Scaffold(
      appBar: _buildAppBar(user.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            quizzes.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Loading quizzes...',
                    ),
                  )
                : QuizListWidget(quizzes)
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
}
