import 'package:e_com_task/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final title = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static final subtitle = GoogleFonts.poppins(
    fontSize: 15,
    color: AppColors.secondaryText.shade700,
    fontWeight: FontWeight.normal,
  );

  static final paymentsectiontext = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static final sectionTitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  );
  static final sectionSubTitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText.shade600,
  );
  static final sectionbody = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText.shade800,
  );

  static final body = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.secondaryText,
    height: 1,
  );
  static final primarybuttontextstyle = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.buttonText,
    fontWeight: FontWeight.bold,
  );
  static final secondarybuttontextstyle = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.accent,
    fontWeight: FontWeight.bold,
  );
}
