
// ignore_for_file: deprecated_member_use

import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/auth/presentation/view/login_screen.dart';
import 'package:bookia_app/features/auth/presentation/widgets/create_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class OTPVerfication extends StatefulWidget {
  const OTPVerfication({super.key});

  @override
  State<OTPVerfication> createState() => _OTPVerficationState();
}

class _OTPVerficationState extends State<OTPVerfication> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  String otpCode = '';

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 50,
      height: 55,
      textStyle: TextStyles.headline,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.4)),
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
      ),
    );

    final submittedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primaryColor),
        color: AppColors.primaryColor.withOpacity(0.05),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
                Text("OTP Verification", style: TextStyles.headline),
                const Gap(8),
                Text(
                  "Enter the verification code we just sent on your email address.",
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                ),
            
                const Gap(40),
            
                Center(
                  child: Pinput(
                    length: 5,
                    controller: pinController,
                    defaultPinTheme: defaultTheme,
                    focusedPinTheme: focusedTheme,
                    submittedPinTheme: submittedTheme,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      otpCode = value;
                    },
                    onCompleted: (pin) {
                      otpCode = pin;
                      debugPrint("OTP: $otpCode");
                    },
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Please enter the full code';
                      }
                      return null;
                    },
                  ),
                ),
            
                const Gap(60),
            
                MainButton(
                  text: "Verify",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      pushTo(context, const NewPassword());
                    }
                  },
                ),
            
                const Spacer(),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn’t received code?',
                      style: TextStyles.caption1,
                    ),
                    const Gap(5),
                    GestureDetector(
                      onTap: () {
                        pushReplacement(context, const LoginScreen());
                      },
                      child: Text(
                        'Resend',
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

