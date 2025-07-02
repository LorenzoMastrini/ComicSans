
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class ComicSansTheme {
  // tema chiaro
  static TextTheme lightTextTheme = TextTheme(
    headlineSmall: GoogleFonts.lato(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.black
    ),
    titleLarge: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.black
    ),
    titleMedium: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: Colors.black
    ),
    titleSmall: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.black
    ),
    bodyLarge: GoogleFonts.lato(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.black
    ),
    bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.black
    ),
    labelLarge: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: Colors.black
    ),
  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      //colorSchemeSeed: Colors.orange,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.orange,
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        // Color(0x12FFFFFF),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: lightTextTheme.titleMedium,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        indicatorShape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.orange, width: 3),
            borderRadius: BorderRadius.circular(16)
        ),
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