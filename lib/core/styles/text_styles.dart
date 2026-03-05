import 'package:bookia_app/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle headline = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 30,
  );
  static TextStyle title = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 24,
  );
  static TextStyle subtitle1 = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 20,
  );
  static TextStyle subtitle2 = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 18,
  );
  static TextStyle body = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 16,
  );
  static TextStyle caption1 = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 14,
  );
  static TextStyle caption2 = TextStyle(
    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
    fontSize: 12,
    color: AppColors.greyColor,
  );
}
