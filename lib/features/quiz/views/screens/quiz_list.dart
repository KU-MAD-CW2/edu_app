import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/quiz/views/widgets/quiz_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:edu_app/features/quiz/controllers/quiz_provider.dart';
import 'package:edu_app/features/quiz/views/widgets/app_bar_widget.dart';

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
      appBar: AppBarWidget(user.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                suffixIcon: const Icon(Icons.search, color: Colors.black),
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                // quizNotifier.search(value);
              },
            ),
            SizedBox(height: 16),
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
}
