import 'package:edu_app/features/quiz/models/quiz.dart';
import 'package:edu_app/features/quiz/models/quiz_details.dart';
import 'package:edu_app/utils/request.dart';

class QuizService {
  Future<List<Quiz>> getQuizzes() async {
    try {
      final response = await Request().get('/quizzes');
      final data = (response['data'] as List)
          .map((json) => Quiz.fromJson(json))
          .toList();
      return data;
    } catch (e) {
      throw Exception('Failed to load quizzes $e');
    }
  }

  Future<QuizDetailsModel> getQuiz(int id) async {
    try {
      final response = await Request().get('/quiz/$id');
      final data = QuizDetailsModel.fromJson(response['data']);
      return data;
    } catch (e) {
      throw Exception('Failed to load quiz $e');
    }
  }
}
