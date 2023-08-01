import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static late SharedPreferences sharedPreferences;
  static Future cacheInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> SaveUserToken(
      {required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  static String? getUser({String key = 'token'}) {
    return sharedPreferences.getString(key);
  }
}
