import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black87,
        surface: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      
      // Tipografía limpia sin distracciones
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        titleLarge: GoogleFonts.inter(
          fontSize: 24, 
          fontWeight: FontWeight.bold, 
          color: Colors.black,
          letterSpacing: -0.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16, 
          color: Colors.black87,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}