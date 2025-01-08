import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_app/features/quiz/models/quiz.dart';
import 'package:edu_app/services/quiz_service.dart';

final quizDetailsProvider =
    StateNotifierProvider<QuizDetailsNotifier, Quiz?>((ref) {
  return QuizDetailsNotifier();
});

class QuizDetailsNotifier extends StateNotifier<Quiz?> {
  QuizDetailsNotifier() : super(null);

  bool _isLoading = false;
  bool isLoading() => _isLoading;

  Future<void> fetchQuiz(int id) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      final response = await QuizService().getQuiz(id);
      state = response;
    } catch (e) {
      throw Exception('Failed to fetch quiz: $e');
    } finally {
      _isLoading = false;
    }
  }
}
