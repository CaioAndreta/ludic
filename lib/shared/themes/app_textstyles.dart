import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludic/shared/themes/app_colors.dart';

class TextStyles {
  static final purpleTitleText = GoogleFonts.roboto(
      fontSize: 24, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final whiteTitleText = GoogleFonts.roboto(
      fontSize: 18, color: AppColors.secondary, fontWeight: FontWeight.bold);
  static final purpleCodigoSala = GoogleFonts.roboto(
      fontSize: 20, color: AppColors.primary, fontWeight: FontWeight.bold);
  static final purpleHintText = GoogleFonts.roboto(color: AppColors.primary);
  static final blackHintText =
      GoogleFonts.roboto(color: AppColors.black, fontSize: 24);
  static final whiteHintText = GoogleFonts.roboto(color: AppColors.secondary);
  static final whitetxtCodigoSala =
      GoogleFonts.roboto(color: AppColors.secondary, fontSize: 24);
  static final cardTitle =
      GoogleFonts.roboto(color: AppColors.black, fontSize: 18);
  static final cardDate =
      GoogleFonts.roboto(color: AppColors.black, fontSize: 16);
  static final cardDesc =
      GoogleFonts.roboto(color: AppColors.body, fontSize: 16);
}
