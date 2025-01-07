import 'dart:convert';

import 'package:edu_app/utils/request.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await Request().post('/login',
        body: {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'});
    return response;
  }

  static Future<Map<String, dynamic>> register(
      Map<String, dynamic> data) async {
    final response = await Request().post(
      '/register',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }
}
