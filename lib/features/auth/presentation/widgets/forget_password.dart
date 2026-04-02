import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/custom_text_form_field.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/auth/presentation/view/login_screen.dart';
import 'package:bookia_app/features/auth/presentation/widgets/otp_verfication.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            pushTo(context, LoginScreen());
          },
          child: SvgPicture.asset(AppImages.back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          left: 20,
          bottom: 60,
          right: 20,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forgot Password?".tr(), style: TextStyles.headline),
                Gap(8),
                Text(
                  "We need to verify you. We will send you a one time verification code.".tr(),
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                ),
                Gap(30),
                CustomTextFormField(
                  hintText: "Enter your email".tr(),
                  controller: phoneController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number'.tr();
                    }
                    return null;
                  },
                ),

                Gap(60),
                MainButton(
                  text: "Send Code",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      pushTo(context, OTPVerfication());
                    }
                  },
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Remember Password?'.tr(), style: TextStyles.caption1),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
