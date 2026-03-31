import 'dart:developer';

import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/profile/data/models/update_profile_params.dart';
import 'package:bookia_app/features/profile/data/models/update_profile_model/update_profile_reponse.dart';


class ProfileRepo {
  static Future<UpdateProfileResponse?> editProfile(
    UpdateProfileParams params,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.updateProfile,
        data: params.toJson(),
        headers: {
          'Content-Type': 'multipart/form-data',
          "authorization": "Bearer ${SharedPref.getToken()}",
        },
      );

      if (response.statusCode == 200) {
        var data = UpdateProfileResponse.fromJson(response.data);
        SharedPref.setUserInfo(data.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
