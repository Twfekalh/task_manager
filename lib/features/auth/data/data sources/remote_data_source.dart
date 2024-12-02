// lib/features/auth/data/data%20sources/remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/features/auth/data/models/user_model.dart';

class UserRemoteDataSource {
  final String baseUrl;

  UserRemoteDataSource(this.baseUrl);

  // تسجيل الدخول
  Future<UserModel> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/docs/auth'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data); // تحويل JSON إلى UserModel
    } else {
      throw Exception('Failed to login');
    }
  }

  // جلب بيانات المستخدم
  Future<UserModel> fetchUserData(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data); // تحويل JSON إلى UserModel
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  // تحديث الجلسة باستخدام refreshToken
  Future<UserModel> refreshSession(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'refreshToken': refreshToken,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data); // تحويل JSON إلى UserModel
    } else {
      throw Exception('Failed to refresh session');
    }
  }
}
