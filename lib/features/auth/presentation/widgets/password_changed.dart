import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/auth/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: SvgPicture.asset(AppImages.success)),
          Gap(20),
          Text(
            "Password Changed!Password Changed!Your password has been changed successfully.Your password has been changed successfully.Back to LoginBack to Login",
            style: TextStyles.headline,
          ),
          Gap(10),
          Text(
            "Your password has been changed successfully.",
            style: TextStyles.caption1.copyWith(color: AppColors.darkGreyColor),
          ),
          Gap(20),
          MainButton(
            text: "Back to Login",
            onPressed: () {
              pushTo(context, LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
