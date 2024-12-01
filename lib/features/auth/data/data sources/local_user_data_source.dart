// lib/data/datasources/local/user_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';

class LocalUserDataSource {
  // حفظ بيانات المستخدم
  Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'userData', jsonEncode(user.toJson())); // تخزين البيانات بتنسيق JSON
    await prefs.setString(
        'accessToken', user.accessToken ?? ''); // تخزين الـ accessToken
    await prefs.setString(
        'refreshToken', user.refreshToken ?? ''); // تخزين الـ refreshToken
  }

  // استرجاع بيانات المستخدم
  Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      return UserModel.fromJson(
          jsonDecode(userData)); // تحويل البيانات من JSON إلى UserModel
    }
    return null; // في حالة عدم وجود بيانات للمستخدم
  }

  // مسح بيانات المستخدم
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
