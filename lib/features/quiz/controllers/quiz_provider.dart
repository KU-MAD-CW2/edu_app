import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_app/features/quiz/models/quiz.dart';
import 'package:edu_app/services/quiz_service.dart';

final quizNotifierProvider =
    StateNotifierProvider<QuizNotifier, List<Quiz>>((ref) {
  return QuizNotifier();
});

class QuizNotifier extends StateNotifier<List<Quiz>> {
  QuizNotifier() : super([]);

  bool _isLoading = false;
  bool isLoading() => _isLoading;

  Future<void> fetchQuizzes() async {
    if (_isLoading) return;
    _isLoading = true;
    state = [];
    try {
      List<Quiz> response = await QuizService().getQuizzes();
      state = response;
    } catch (e) {
      throw Exception('Failed to fetch quizzes: $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> searchQuizzes(String keyword) async {
    if (_isLoading) return;
    _isLoading = true;
    state = [];
    try {
      List<Quiz> response = await QuizService().searchQuizzes(keyword);
      state = response;
    } catch (e) {
      throw Exception('Failed to fetch quizzes: $e');
    } finally {
      _isLoading = false;
    }
  }
}
