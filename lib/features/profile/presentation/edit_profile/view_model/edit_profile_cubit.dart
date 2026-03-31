import 'dart:io';
import 'package:bookia_app/core/services/local/shared_preferences.dart';
import 'package:bookia_app/features/profile/data/models/update_profile_params.dart';
import 'package:bookia_app/features/profile/data/repo/profile_repo.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial()) {
    loadInitData();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String imageUrl = '';

  void loadInitData() {
    var profileData = SharedPref.getUserInfo();
    nameController.text = profileData?.name ?? '';
    phoneController.text = profileData?.phone ?? '';
    addressController.text = profileData?.address ?? '';
    passwordController.text = profileData?.password?? '';
    confirmPasswordController.text = profileData?.confirmPassword ?? '';
    imageUrl = profileData?.image ?? '';
    emit(EditProfileInitial());
  }

  Future<void> updateProfile(File? image) async {
    emit(EditProfileLoading());

    try {
      var params = UpdateProfileParams(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        image: (image != null && image.path.isNotEmpty)
            ? image
            : null, // ✅ Check if image exists
      );

      var data = await ProfileRepo.editProfile(params);

      if (data != null) {
        imageUrl = data.data?.image ?? imageUrl;
        emit(EditProfileSuccess());
      } else {
        emit(EditProfileError());
      }
    } catch (e) {
      emit(EditProfileError());
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    return super.close();
  }
}
