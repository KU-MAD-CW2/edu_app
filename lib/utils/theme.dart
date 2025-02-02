import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static MaterialColor primaryColor = Colors.red;

  setPrimaryColor(MaterialColor color) {
    primaryColor = color;
  }

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    primaryColor: primaryColor,
    secondaryHeaderColor: Colors.grey.shade300,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: Colors.grey.shade300,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    cardTheme: CardTheme(
        color: Colors.grey.shade100, shadowColor: Colors.white, elevation: 0),
    chipTheme: ChipThemeData(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.grey.shade100),
        ),
        backgroundColor: Colors.grey.shade100,
        surfaceTintColor: Colors.grey.shade100,
        labelStyle: lightTextTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade800,
          overflow: TextOverflow.visible,
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor.shade500,
        textStyle: lightTextTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primaryColor.shade500),
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      canvasColor: Colors.black45,
      scaffoldBackgroundColor: Colors.black45,
      textTheme: darkTextTheme,
      secondaryHeaderColor: Colors.black54,
      primaryColor: primaryColor,
      chipTheme: ChipThemeData(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.grey.shade900,
        surfaceTintColor: Colors.grey.shade800,
      ),
      cardTheme: CardTheme(
        color: Colors.grey.shade900,
        shadowColor: Colors.black45,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black45,
        surfaceTintColor: Colors.black45,
      ),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black38,
          surfaceTintColor: Colors.black38,
          indicatorColor: Colors.grey.shade300,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          shadowColor: Colors.black),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor.shade500));

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      color: primaryColor,
      fontSize: 36,
      height: 0.9,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall:
        GoogleFonts.inter(fontSize: 20, height: 1, fontWeight: FontWeight.w600),
    titleLarge:
        GoogleFonts.inter(fontSize: 36, height: 1, fontWeight: FontWeight.w500),
    titleMedium:
        GoogleFonts.inter(fontSize: 20, height: 1, fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.inter(
        fontSize: 18, height: 1.5, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.inter(
      fontSize: 15,
      height: 1.5,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 13,
      height: 1.2,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: primaryColor,
        fontSize: 36,
        height: 0.9,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.inter(
          fontSize: 20, height: 1, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.inter(
          fontSize: 36, height: 1, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.inter(
          fontSize: 20, height: 1, fontWeight: FontWeight.w400),
      bodyLarge: GoogleFonts.inter(
          fontSize: 14, height: 1.5, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(
        fontSize: 12,
        height: 1.5,
      ));

  static TextStyle logoTitleOne = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 36,
  );
}
