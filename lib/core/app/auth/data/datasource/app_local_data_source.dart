import 'package:shared_preferences/shared_preferences.dart';

abstract class AppLocalDataSource {
  Future<void> setUserData(data);
  String getUserData();
  Future<void> removeUserData();
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  final SharedPreferences pref;
  static const String _userIdKey = "USER_ID";

  AppLocalDataSourceImpl(this.pref);
  @override
  String getUserData() {
    if (pref.getString(_userIdKey) != null) {
      return pref.getString(_userIdKey)!;
    }
    return '';
  }

  @override
  Future<void> removeUserData() {
    return pref.remove(_userIdKey);
  }

  @override
  Future<void> setUserData(data) {
    return pref.setString(_userIdKey, data);
  }
}
