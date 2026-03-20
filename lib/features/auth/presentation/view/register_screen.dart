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
import 'package:bookia_app/features/auth/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
        body: _registerBody(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(22, 5, 22, 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?', style: TextStyles.caption1),
              Gap(5),
              GestureDetector(
                onTap: () {
                  pushReplacement(context, LoginScreen());
                },
                child: Text(
                  'Login',
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

  BlocConsumer<AuthCubit, AuthState> _registerBody() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          log("success");
          pushToBase(context, MainAppScreen());
        } else if (state is AuthErrorState) {
          pop(context);
          log("error");
          showErrorDialog(context, state.message);
        } else if (state is AuthLoadingState) {
          log("loading");
          showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthCubit>();
        return MyBodyView(
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Hello! Register to get started.',
                    style: TextStyles.headline,
                  ),
                  Gap(32),
                  CustomTextFormField(
                    controller: cubit.usernameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  CustomTextFormField(
                    controller: cubit.emailController,
                    hintText: 'Email',
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
                    hintText: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  PasswordTextFormField(
                    controller: cubit.passwordConfirmationController,
                    hintText: 'Confirmation password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your confirmation password';
                      }
                      return null;
                    },
                  ),
                  if (true) Gap(30),
                  MainButton(
                    text: 'Register',
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.register();
                      }
                    },
                  ),
                  Gap(35),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
