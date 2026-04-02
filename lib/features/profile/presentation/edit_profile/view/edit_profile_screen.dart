import 'dart:io';
import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/functions/validations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_svg_picture.dart';
import 'package:bookia_app/core/widgets/custom_text_form_field.dart';
import 'package:bookia_app/core/widgets/dialogs.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:bookia_app/features/profile/presentation/profile/view/profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  String path = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          pop(context);
          pop(context);
        } else if (state is EditProfileError) {
          pop(context);
          showMyDialog(context, 'Failed to update profile. Please try again.'.tr());
        } else if (state is EditProfileLoading) {
          showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<EditProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                pushTo(context, ProfileScreen());
              },
              child: SvgPicture.asset(AppImages.back),
            ),
            //leading: ,
            //  IconButton(
            //   onPressed: () {
            //     pushTo(context, ProfileScreen());
            //   },
            //   icon: Icon(Icons.arrow_back_ios_new),
            // ),
            title: Text('Edit Profile', style: TextStyles.title),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: MyBodyView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (path.isNotEmpty)
                        ClipOval(
                          child: Image.file(
                            File(path),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (path.isEmpty && cubit.imageUrl.isNotEmpty)
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: cubit.imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              size: 100,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      if (path.isEmpty && cubit.imageUrl.isEmpty)
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.accentColor,
                          child: CustomSvgPicture(
                            path: AppImages.profileSvg,
                            color: AppColors.primaryColor,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            pickProfileImage();
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.backgroundColor,
                            child: CustomSvgPicture(path: AppImages.cameraSvg),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(50),
                  CustomTextFormField(
                    controller: cubit.nameController,
                    hintText: 'Full Name'.tr(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    hintText: 'Phone',
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty == true &&
                          !isEgyptianPhone(value)) {
                        return 'Please enter a valid Egyptian phone number'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.addressController,
                    hintText: 'Address'.tr(),
                  ),
                ],
              ),
            ),
          ),

          // In your EditProfileScreen bottomNavigationBar button:
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: MainButton(
              text: 'Update Profile',
              onPressed: () {
                File? imageFile;
                if (path.isNotEmpty) {
                  imageFile = File(path);
                }
                cubit.updateProfile(imageFile);
              },
            ),
          ),
        );
      },
    );
  }

  void pickProfileImage() async {
    var picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        path = image.path;
      });
    }
  }
}
