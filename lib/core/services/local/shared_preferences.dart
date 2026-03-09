import 'dart:convert';
import 'package:bookia_app/features/auth/data/models/auth_model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences pref;

  static const String kToken = 'token';
  static const String kUser = 'user';

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String value) async {
    await pref.setString(kToken, value);
  }

  static String? getToken() {
    return pref.getString(kToken);
  }

  static Future<void> setUserInfo(User? model) async {
    if (model == null) {
      return;
    }
    var objToJson = model.toJson();
    var jsonToString = jsonEncode(objToJson);
    await pref.setString(kUser, jsonToString);
  }

  static User? getUserInfo() {
    var cachedString = pref.getString(kUser);

    if (cachedString == null) {
      return null;
    }
    var stringToJson = jsonDecode(cachedString);
    var jsonToObject = User.fromJson(stringToJson);
    return jsonToObject;
  }

  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    }
  }

  static Object getData(String key) {
    return pref.get(key) ?? '';
  }

  static Future<void> removeData(String key) async {
    await pref.remove(key);
  }

  static Future<void> clear() async {
    await pref.clear();
  }
}
