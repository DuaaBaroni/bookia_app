import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/core/widgets/password_text_form_field.dart';
import 'package:bookia_app/features/auth/presentation/widgets/otp_verfication.dart';
import 'package:bookia_app/features/auth/presentation/widgets/password_changed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
            pushTo(context, OTPVerfication());
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create new password", style: TextStyles.headline),
              Gap(8),
              Text(
                "Your new password must be unique from those previously used.",
                style: TextStyles.caption1.copyWith(
                  color: AppColors.darkGreyColor,
                ),
              ),
              Gap(30),
              PasswordTextFormField(
                controller: passwordController,
                hintText: 'New Password'.tr(),
              ),
              Gap(10),
              PasswordTextFormField(
                controller: passwordController,
                hintText: 'Confirm Password'.tr(),
              ),
              Gap(60),
              MainButton(
                text: "Reset Password",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    pushTo(context, PasswordChanged());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
