import 'dart:developer';
import 'package:dio/dio.dart';
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
      // ✅ DEBUG: Print what we're sending
      log('🔵 UPDATE PROFILE REQUEST:');
      log('   Name: ${params.name}');
      log('   Phone: ${params.phone}');
      log('   Address: ${params.address}');
      log('   Image: ${params.image?.path ?? "No image"}');

      // Convert to FormData
      final formData = await params.toFormData();

      // ✅ DEBUG: Print FormData fields
      log('📦 FormData Fields:');
      formData.fields.forEach((field) {
        log('   ${field.key}: ${field.value}');
      });
      
      formData.files.forEach((file) {
        log('   ${file.key}: ${file.value.filename}');
      });

      var response = await DioProvider.post(
        endpoint: Apis.updateProfile,
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          "authorization": "Bearer ${SharedPref.getToken()}",
        },
      );

      log('✅ Response Status: ${response.statusCode}');
      log('✅ Response Data: ${response.data}');

      if (response.statusCode == 200) {
        var data = UpdateProfileResponse.fromJson(response.data);
        SharedPref.setUserInfo(data.data);
        return data;
      } else {
        log('❌ Failed with status: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      log('❌ DioException: ${e.response?.statusCode}');
      log('❌ Error Response: ${e.response?.data}');
      log('❌ Error Message: ${e.message}');
      return null;
    } catch (e) {
      log('❌ Exception: $e');
      return null;
    }
  }
}