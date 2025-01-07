import 'package:edu_app/utils/request.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(Map<String, String> data) async {
    final response = await Request().post('/login',
        body: data, headers: {'Content-Type': 'application/json'});
    return response;
  }

  static Future<Map<String, dynamic>> register(
      Map<String, dynamic> data) async {
    final response = await Request().post('/register',
        body: data, headers: {'Content-Type': 'application/json'});
    return response;
  }
}
