import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



final Color quaternary = Color(0xFF669bbc);

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
      color: Color(0xFF0C3148)
    ),
  );

  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFFf9f4ed),
      useMaterial3: true,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Color(0xFFc11720),
        secondary: Color(0xFF0C3148),
        tertiary: Color(0xFFf9f4ed),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Color(0xFF0C3148),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: lightTextTheme.titleMedium,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFFc11720),
          ),
        ),
        backgroundColor: Color(0xFFf9f4ed),
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: Color(0xFF0C3148),
        unselectedLabelColor: Color(0xFF0C3148),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: Color(0xFFc11720)),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Color(0xFF0C3148);
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Color(0xFFc11720);
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Color(0xFFc11720);
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        checkmarkColor: Color(0xFFf9f4ed),
        color: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Color(0xFF0C3148);
          }
          return null;
        }),
      ),
      textTheme: lightTextTheme,
    );
  }
}