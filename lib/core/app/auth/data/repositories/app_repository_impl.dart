import 'dart:async';
import 'package:servit_project_version_2/core/app/auth/data/datasource/app_local_data_source.dart';
import 'package:servit_project_version_2/core/app/auth/data/datasource/app_remote_data_source.dart';
import 'package:servit_project_version_2/core/app/auth/domain/repositories/app_repositories.dart';
import 'package:servit_project_version_2/features/user/auth/data/model/user_model.dart';

class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource authRemoteDataSource;
  final AppLocalDataSource authLocalDataSource;

  AppRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  String getCurrentUser() {
    final result = authLocalDataSource.getUserData();
    return result;
  }

  @override
  Future<void> logoutUser() async {
    await authRemoteDataSource.logoutUser();
    await authLocalDataSource.removeUserData();
  }

  @override
  Stream<UserModel> get user {
    final user = authRemoteDataSource.user;
    return user;
  }

  @override
  Future<void> setCurrentUser() async {
    await authLocalDataSource.setUserData(user);
  }
}
