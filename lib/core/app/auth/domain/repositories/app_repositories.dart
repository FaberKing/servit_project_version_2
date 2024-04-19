import 'package:servit_project_version_2/features/user/auth/data/model/user_model.dart';

abstract class AppRepository {
  String getCurrentUser();
  Future<void> setCurrentUser();
  Future<void> logoutUser();
  Stream<UserModel> get user;
}
