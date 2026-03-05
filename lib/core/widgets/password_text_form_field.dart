import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({super.key, this.hintText});
  final String? hintText;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      obscureText: obscureText,
      decoration: InputDecoration(
        suffix: Icon(Icons.remove_red_eye_rounded, size: 18, color: AppColors.greyColor,),
        hintText: "Enter your password",
        hintStyle: TextStyles.caption1.copyWith(
          color: AppColors.greyColor,
          fontSize: 10,
        ),

        fillColor: AppColors.accentColor.withOpacity(0.4),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.backgroundColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (input) {
        if (input!.isEmpty) {
          return 'Please enter your password';
        } else if (input.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
