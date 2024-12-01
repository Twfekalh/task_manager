import 'package:task_manager/features/auth/data/data%20sources/local_user_data_source.dart';
import 'package:task_manager/features/auth/data/data%20sources/remote_data_source.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final LocalUserDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserModel> loginUser(String username, String password) async {
    final user = await remoteDataSource.loginUser(username, password);
    await localDataSource
        .saveUserData(user); // حفظ بيانات المستخدم محليًا بعد تسجيل الدخول
    return user;
  }

  @override
  Future<UserModel> fetchUserData(String accessToken) async {
    return await remoteDataSource.fetchUserData(accessToken);
  }

  @override
  Future<UserModel> refreshSession(String refreshToken) async {
    final user = await remoteDataSource.refreshSession(refreshToken);
    await localDataSource.saveUserData(user); // حفظ البيانات بعد التحديث
    return user;
  }
}
