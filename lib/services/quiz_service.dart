import 'package:edu_app/features/quiz/models/quiz.dart';
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

  // Future<Quiz> getQuiz(int id) async {
  //   final response = await Request.get('/quizzes/$id');

  //   if (response.statusCode == 200) {
  //     return Quiz.fromJson(response.json());
  //   } else {
  //     throw Exception('Failed to load quiz');
  //   }
  // }
}
