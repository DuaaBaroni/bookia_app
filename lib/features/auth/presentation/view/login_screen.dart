// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/functions/validations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/bottom_navigation_bar.dart';
import 'package:bookia_app/core/widgets/custom_svg_picture.dart';
import 'package:bookia_app/core/widgets/custom_text_form_field.dart';
import 'package:bookia_app/core/widgets/dialogs.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/core/widgets/my_body_view.dart';
import 'package:bookia_app/core/widgets/password_text_form_field.dart';
import 'package:bookia_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia_app/features/auth/presentation/widgets/forget_password.dart';
import 'package:bookia_app/features/auth/presentation/view/register_screen.dart';
import 'package:bookia_app/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => pop(context),
            child: CustomSvgPicture(path: AppImages.backSvg),
          ),
        ),
        body: _loginBody(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(22, 5, 22, 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?', style: TextStyles.caption1),
              Gap(5),
              GestureDetector(
                onTap: () {
                  pushTo(context, RegisterScreen());
                },
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

  Widget _loginBody() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          print("successss");
          pop(context);
          pushToBase(context, MainAppScreen());
        } else if (state is AuthErrorState) {
          pop(context);
          showErrorDialog(context, state.message);
        } else if (state is AuthLoadingState) {
          log("loading");
          showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthCubit>();
        return MyBodyView(
          //bottomNavigationBar: Padding(padding: EdgeInsets.all(10)),
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Welcome back! Glad to see you, Again!',
                    style: TextStyles.headline,
                  ),
                  Gap(32),
                  CustomTextFormField(
                    controller: cubit.emailController,
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
                    controller: cubit.passwordController,
                    hintText: 'Enter your password',
                  ),
                  Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pushTo(context, ForgetPassword());
                        },
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
                  MainButton(
                    text: 'Login',
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.login();
                      }
                    },
                  ),
                  Gap(35),
                  SocialLoginButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
