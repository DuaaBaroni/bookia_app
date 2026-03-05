import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onChange,
    this.textInputAction,
    this.controller,
  });
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
       decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.caption1.copyWith
        (color: AppColors.greyColor, fontSize: 10),
        prefixIcon: prefixIcon,
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
    );
  }
}
