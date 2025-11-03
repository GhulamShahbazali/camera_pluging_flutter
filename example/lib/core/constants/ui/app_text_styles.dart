import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static const double h1 = 47;
  static const double h2 = 47;
  static const double h3 = 45;
  static const double h3_1 = 40;
  static const double h4 = 37;
  static const double h6 = 20;
  static const double h5 = 20;

  ///
  static const double t1 = 15;

  ///
  static const double b1 = 12;
  static const double b2 = 14;

  // Font weights
  static const FontWeight _fontWeightNormal = FontWeight.w400;
  static const FontWeight _fontWeightMedium = FontWeight.w500;
  static const FontWeight _fontWeightBold = FontWeight.w700;
  static const FontWeight _fontWeightExtraBold = FontWeight.w800;

  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: h1,
    fontWeight: _fontWeightBold,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.rajdhani,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: h2,
    fontWeight: _fontWeightMedium,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.rajdhani,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: h3,
    fontWeight: _fontWeightExtraBold,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.inter,
  );
  static const TextStyle heading3_1 = TextStyle(
    fontSize: h3_1,
    fontWeight: _fontWeightExtraBold,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.inter,
  );
  static const TextStyle heading4 = TextStyle(
    fontSize: h4,
    fontWeight: _fontWeightNormal,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.roboto,
  );
  static const TextStyle heading5 = TextStyle(
    fontSize: h6,
    fontWeight: _fontWeightBold,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.rajdhani,
  );
  static const TextStyle heading6 = TextStyle(
    fontSize: h6,
    fontWeight: _fontWeightNormal,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.rajdhani,
  );

  // title
  static const TextStyle title1 = TextStyle(
    fontSize: t1,
    fontWeight: _fontWeightMedium,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.roboto,
  );
  // body text
  static const TextStyle body1 = TextStyle(
    fontSize: b1,
    fontWeight: _fontWeightBold,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.inter,
  );
  static const TextStyle body2 = TextStyle(
    fontSize: b2,
    fontWeight: _fontWeightBold,
    color: AppColors.whiteColor,
    fontFamily: AppFonts.inter,
  );
}
