import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class TextStyles {
  static final primaryTitleText = GoogleFonts.dmSans(
      fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final secondaryTitleText = GoogleFonts.dmSans(
      fontSize: 18, color: AppColors.secondary, fontWeight: FontWeight.bold);
  static final primaryCodigoSala = GoogleFonts.dmSans(
      fontSize: 20, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final primaryHintText = GoogleFonts.dmSans(color: AppColors.primary);
  static final blackTitleText =
      GoogleFonts.dmSans(color: AppColors.dark, fontSize: 24);
  static final blackHintText =
      GoogleFonts.dmSans(color: Color(0xff525252), fontSize: 16);
  static final secondaryHintText =
      GoogleFonts.dmSans(color: AppColors.secondary);
  static final secondaryTxtCodigoSala =
      GoogleFonts.dmSans(color: AppColors.secondary, fontSize: 24);
  static final cardTitle =
      GoogleFonts.dmSans(color: AppColors.dark, fontSize: 18);
  static final cardDate =
      GoogleFonts.dmSans(color: AppColors.dark, fontSize: 16);
  static final cardDesc =
      GoogleFonts.dmSans(color: AppColors.body, fontSize: 16);
}
