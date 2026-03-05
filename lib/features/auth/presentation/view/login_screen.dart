// ignore_for_file: sort_child_properties_last

import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/functions/validations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_svg_picture.dart';
import 'package:bookia_app/core/widgets/custom_text_form_field.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/core/widgets/password_text_form_field.dart';
import 'package:bookia_app/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => pop(context),
          child: CustomSvgPicture(path: AppImages.backSvg),
        ),
      ),
      body: MyBodyView(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Welcome back! Glad to see you, Again!',
                  style: TextStyles.headline,
                ),
                Gap(32),
                CustomTextFormField(
                  
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isEmailValid(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                Gap(15),
                PasswordTextFormField(
                  hintText: 'Enter your password',
                ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyles.caption1.copyWith(
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(30),
                MainButton(text: 'Login', onPressed: () {}),
                Gap(35),
                SocialLoginButtons(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(22, 5, 22, 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?', style: TextStyles.caption1),
              Gap(5),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Register',
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
