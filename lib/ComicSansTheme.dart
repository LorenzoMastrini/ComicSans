import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ComicSansTheme {
  // tema chiaro
  static TextTheme lightTextTheme = TextTheme(
      headlineSmall: GoogleFonts.poppins(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      color: Colors.black
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFF0C3148)
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Color(0xFF0C3148)
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.black
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.black
    ),
  );

  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFFf9f4ed),
      useMaterial3: true,
      //colorSchemeSeed: Colors.orange,
      //colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      colorScheme: const ColorScheme.light().copyWith(
        primary: Color(0xFFc11720),
        secondary: Color(0xFF0C3148),
        tertiary: Color(0xFFf9f4ed),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: lightTextTheme.titleMedium,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFFc11720),
          ),
        ),
        backgroundColor: Color(0xFFf9f4ed),
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      /*
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black26,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: Colors.orange),
        ),
      ),
      */
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.orange;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.orange;
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        checkmarkColor: Colors.white,
        color: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return null;
        }),
      ),
      textTheme: lightTextTheme,
    );
  }
}