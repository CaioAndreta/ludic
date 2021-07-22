import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class TextStyles {
  static final purpleTitleText = GoogleFonts.roboto(
      fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final whiteTitleText = GoogleFonts.roboto(
      fontSize: 18, color: AppColors.background, fontWeight: FontWeight.bold);
  static final purpleHintText = GoogleFonts.roboto(color: AppColors.primary);
  static final whiteHintText = GoogleFonts.roboto(color: AppColors.background);
  static final cardTitle =
      GoogleFonts.roboto(color: AppColors.black, fontSize: 18);
  static final cardDate =
      GoogleFonts.roboto(color: AppColors.black, fontSize: 16);
  static final cardDesc =
      GoogleFonts.roboto(color: AppColors.body, fontSize: 16);
}
