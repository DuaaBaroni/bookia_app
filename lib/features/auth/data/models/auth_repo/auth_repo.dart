import 'dart:developer';
import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/auth/data/models/login_parms.dart';
import 'package:bookia_app/features/auth/data/models/auth_model/register_response.dart';
import 'package:bookia_app/features/auth/data/models/register_parms.dart';

class AuthRepo {
  static Future<AuthResponse?> register(RegisterParams params) async {
    try {
      log(params.toJson().toString());
      var response = await DioProvider.post(
        endpoint: Apis.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        var data = AuthResponse.fromJson(response.data);
        SharedPref.setToken(data.data?.token ?? '');
        SharedPref.setUserInfo(data.data?.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> login(LoginParams params) async {
    try {
      log(params.toJson().toString());

      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);

        SharedPref.setToken(data.data?.token ?? '');
        SharedPref.setUserInfo(data.data?.user);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
