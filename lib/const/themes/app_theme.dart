import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  // primary color
  static const Color primaryDark = Color(0xFF1F1D2B);
  static const Color primarySoft = Color(0xFF252836);
  static const Color primaryBlueAccent = Color(0xFF12CDD9);

  //secondary
  static const Color green = Color(0xFF22B07D);
  static const Color orange = Color(0xFFFF8700);
  static const Color red = Color(0xFFFF7256);

  // text color
  static const Color textColorBlack = Color(0xff171725);
  static const Color textColorDarkGrey = Color(0xff696974);
  static const Color textColorGrey = Color(0xff92929D);
  static const Color textColorWhiteGrey = Color(0xffF1F1F5);
  static const Color textColorWhite = Color(0xffFFFFFF);
  static const Color textColorLineDark = Color(0xffEAEAEA);

  static TextStyle montserrat(
    double size,
    FontWeight width, [
    Color color = textColorWhite,
  ]) {
    return GoogleFonts.montserrat(
      fontSize: size,
      fontWeight: width,
      color: color,
    );
  }

  // === ThemeData ===

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      primaryColor: primaryBlueAccent,
      textTheme: TextTheme(
        displayLarge: montserrat(28, FontWeight.w600),
        displayMedium: montserrat(24, FontWeight.w600),
        displaySmall: montserrat(18, FontWeight.w600),
        headlineLarge: montserrat(16, FontWeight.w600),
        headlineMedium: montserrat(14, FontWeight.w600),
        titleLarge: montserrat(12, FontWeight.w600),
        bodyLarge: montserrat(12, FontWeight.w400),
        bodyMedium: montserrat(12, FontWeight.w500),
      ),
      iconTheme: IconThemeData(color: textColorWhite),
      appBarTheme: AppBarTheme(
        backgroundColor: primarySoft,
        iconTheme: IconThemeData(color: textColorWhite),
        titleTextStyle: montserrat(20, FontWeight.w600),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: textColorWhiteGrey,
      primaryColor: primaryBlueAccent,
      textTheme: TextTheme(
        displayLarge: montserrat(30, FontWeight.w600, textColorBlack),
        displayMedium: montserrat(24, FontWeight.w600, textColorBlack),
        displaySmall: montserrat(18, FontWeight.w600, textColorBlack),
        headlineLarge: montserrat(16, FontWeight.w600, textColorBlack),
        headlineMedium: montserrat(16, FontWeight.w600, textColorBlack),
        headlineSmall: montserrat(14, FontWeight.w600, textColorBlack),
        titleLarge: montserrat(12, FontWeight.w600, textColorBlack),
        bodyLarge: montserrat(12, FontWeight.w400, textColorBlack),
        bodyMedium: montserrat(12, FontWeight.w500, textColorBlack),
      ),
      iconTheme: IconThemeData(color: textColorBlack),
      appBarTheme: AppBarTheme(
        backgroundColor: textColorWhite,
        iconTheme: IconThemeData(color: textColorBlack),
        titleTextStyle: montserrat(20, FontWeight.w600, textColorBlack),
      ),
    );
  }
}
