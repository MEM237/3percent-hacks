import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF4A4A4A), // Dark steel
        secondary: const Color(0xFF7A7A7A), // Medium steel
        tertiary: const Color(0xFFB8B8B8), // Light steel
        surface: const Color(0xFFE8E8E8), // Brushed steel light
        background: const Color(0xFFF5F5F5), // Light metallic
        error: const Color(0xFFB71C1C),
        onPrimary: const Color(0xFFFFFFFF),
        onSecondary: const Color(0xFF000000),
        onTertiary: const Color(0xFF000000),
        onSurface: const Color(0xFF1A1A1A),
        onBackground: const Color(0xFF1A1A1A),
        onError: const Color(0xFFFFFFFF),
        outline: const Color(0xFF8A8A8A),
      ),
      brightness: Brightness.light,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 57.0,
          fontWeight: FontWeight.w300,
          color: const Color(0xFF1A1A1A),
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 45.0,
          fontWeight: FontWeight.w300,
          color: const Color(0xFF1A1A1A),
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF1A1A1A),
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF1A1A1A),
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1A1A1A),
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF1A1A1A),
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF1A1A1A),
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF1A1A1A),
        ),
      ),
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF8A8A8A), // Light steel
        secondary: const Color(0xFF6A6A6A), // Medium steel
        tertiary: const Color(0xFF4A4A4A), // Dark steel
        surface: const Color(0xFF2A2A2A), // Dark metallic
        background: const Color(0xFF1A1A1A), // Deep metallic
        error: const Color(0xFFCF6679),
        onPrimary: const Color(0xFF000000),
        onSecondary: const Color(0xFFFFFFFF),
        onTertiary: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFFE8E8E8),
        onBackground: const Color(0xFFE8E8E8),
        onError: const Color(0xFF000000),
        outline: const Color(0xFF5A5A5A),
      ),
      brightness: Brightness.dark,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 57.0,
          fontWeight: FontWeight.w300,
          color: const Color(0xFFE8E8E8),
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 45.0,
          fontWeight: FontWeight.w300,
          color: const Color(0xFFE8E8E8),
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFE8E8E8),
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFE8E8E8),
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFE8E8E8),
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE8E8E8),
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFE8E8E8),
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFE8E8E8),
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFE8E8E8),
        ),
      ),
    );

// Steel gradient utilities
class SteelGradients {
  static const LinearGradient brushedSteel = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFFA0A0A0),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const LinearGradient darkSteel = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4A4A4A),
      Color(0xFF3A3A3A),
      Color(0xFF2A2A2A),
      Color(0xFF1A1A1A),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const RadialGradient circularSteel = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFF8A8A8A),
    ],
    stops: [0.0, 0.4, 0.7, 1.0],
  );

  static const RadialGradient darkCircularSteel = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [
      Color(0xFF5A5A5A),
      Color(0xFF4A4A4A),
      Color(0xFF3A3A3A),
      Color(0xFF2A2A2A),
    ],
    stops: [0.0, 0.4, 0.7, 1.0],
  );
}