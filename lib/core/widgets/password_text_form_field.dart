// ignore_for_file: deprecated_member_use

import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.validator,
  });
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyles.caption1.copyWith(
          color: AppColors.greyColor,
          fontSize: 10,
        ),
        suffixIcon: IconButton(
          color: AppColors.greyColor,
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(obscureText ? Icons.visibility_off : Icons.remove_red_eye),
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
      validator: widget.validator,
    );
  }
}
