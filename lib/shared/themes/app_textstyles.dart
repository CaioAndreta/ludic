import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class TextStyles {
  static final primaryTitleText = GoogleFonts.roboto(
      fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final secondaryTitleText = GoogleFonts.roboto(
      fontSize: 18, color: AppColors.secondary, fontWeight: FontWeight.bold);
  static final primaryCodigoSala = GoogleFonts.roboto(
      fontSize: 20, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final primaryHintText = GoogleFonts.roboto(color: AppColors.primary);
  static final blackTitleText =
      GoogleFonts.roboto(color: AppColors.dark, fontSize: 24);
  static final blackHintText =
      GoogleFonts.roboto(color: AppColors.dark, fontSize: 16);
  static final secondaryHintText =
      GoogleFonts.roboto(color: AppColors.secondary);
  static final secondaryTxtCodigoSala =
      GoogleFonts.roboto(color: AppColors.secondary, fontSize: 24);
  static final cardTitle =
      GoogleFonts.roboto(color: AppColors.dark, fontSize: 18);
  static final cardDate =
      GoogleFonts.roboto(color: AppColors.dark, fontSize: 16);
  static final cardDesc =
      GoogleFonts.roboto(color: AppColors.body, fontSize: 16);
}
