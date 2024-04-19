import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = Colors.white;

Color primaryColor = const Color(0xFFFFFFFF);

Color pinkColor = const Color(0xfff9f5f6);
Color pinkColor1 = const Color(0xfff8e8ee);
Color pinkColor2 = const Color(0xfffdcedf);
Color pinkColor3 = const Color(0xfff2bed1);

Color greenColor = const Color(0xff0EC3AE);

Color backgroundColor = const Color(0xffF7F7F7);
Color backgroundColor2 = const Color(0xffECEDEF);

Color transaparentColor = Colors.transparent;

const dividerColor = Color.fromRGBO(37, 45, 50, 1);

const ColorScheme colorScheme = ColorScheme.light();

final TextTheme myTextTheme = TextTheme(
  headlineLarge: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
);
