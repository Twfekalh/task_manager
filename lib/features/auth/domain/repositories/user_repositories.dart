import 'package:task_manager/features/auth/domain/entities/user_entites.dart';

abstract class UserRepository {
  Future<User> loginUser(String username, String password);
  Future<User> fetchUserData(String accessToken);
  Future<User> refreshSession(String refreshToken);
}
