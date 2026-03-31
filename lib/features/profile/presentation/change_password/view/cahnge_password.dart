import 'dart:io';
import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/functions/validations.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_text_form_field.dart';
import 'package:bookia_app/core/widgets/dialogs.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:bookia_app/features/profile/presentation/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ChnagePasswordScreen extends StatelessWidget {
  const ChnagePasswordScreen({super.key});

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
          showMyDialog(context, 'Failed to update profile. Please try again.');
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
            
          ),
          body: SingleChildScrollView(
            child: MyBodyView(
              child: Column(
                children: [
                 Text('New Password', style: TextStyles.title),
                
                  const Gap(50),
                  CustomTextFormField(
                    controller: cubit.nameController,
                    hintText: 'Current Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    hintText: 'New Password',
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty == true &&
                          !isEgyptianPhone(value)) {
                        return 'Please enter a valid Egyptian phone number';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomTextFormField(
                    controller: cubit.addressController,
                    hintText: 'Address',
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: MainButton(
              text: 'Confirm password',
              onPressed: () {
                cubit.updateProfile(File(path));
              },
            ),
          ),
        );
      },
    );
  }

  
}
