import 'dart:convert';

import 'package:edu_app/features/auth/models/user.dart';
import 'package:edu_app/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, Map<String, dynamic>?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<Map<String, dynamic>?> {
  AuthNotifier() : super(null) {
    checkLoginStatus();
  }

  Future<bool> login(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await AuthService.login(data);
    if (response['accessToken'] == null) return false;
    await prefs.setString('token', response['accessToken']);
    await prefs.setString('user', jsonEncode(response['user']));
    await checkLoginStatus();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    state = null;
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final user = prefs.getString('user');

    if (token != null && user != null) {
      state = {
        'token': token,
        'user': User.fromJson(jsonDecode(user)),
      };
    } else {
      state = null;
    }
  }
}
