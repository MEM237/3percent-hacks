import 'package:flutter/material.dart';

class SteelGradients {
  // Brushed steel effect gradients
  static const LinearGradient brushedHorizontal = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFFD0D0D0),
      Color(0xFFE8E8E8),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient brushedVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFFD0D0D0),
      Color(0xFFE8E8E8),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  // Circular steel gradients for circular viewer
  static const RadialGradient circularBrushed = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [
      Color(0xFFF0F0F0),
      Color(0xFFE0E0E0),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFFA0A0A0),
    ],
    stops: [0.0, 0.2, 0.5, 0.8, 1.0],
  );

  static const RadialGradient circularDark = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [
      Color(0xFF6A6A6A),
      Color(0xFF5A5A5A),
      Color(0xFF4A4A4A),
      Color(0xFF3A3A3A),
      Color(0xFF2A2A2A),
    ],
    stops: [0.0, 0.2, 0.5, 0.8, 1.0],
  );

  // Beveled edge effect for buttons and containers
  static const LinearGradient beveledEdge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
    ],
    stops: [0.0, 0.2, 0.8, 1.0],
  );

  static const LinearGradient darkBeveledEdge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7A7A7A),
      Color(0xFF6A6A6A),
      Color(0xFF4A4A4A),
      Color(0xFF3A3A3A),
    ],
    stops: [0.0, 0.2, 0.8, 1.0],
  );

  // Industrial button gradients
  static const LinearGradient industrialButton = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFFA0A0A0),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const LinearGradient industrialButtonPressed = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFA0A0A0),
      Color(0xFFB8B8B8),
      Color(0xFFD0D0D0),
      Color(0xFFE8E8E8),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  // Navigation bar steel effect
  static const LinearGradient navBarSteel = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE8E8E8),
      Color(0xFFD0D0D0),
      Color(0xFFB8B8B8),
      Color(0xFFD0D0D0),
      Color(0xFFE8E8E8),
    ],
    stops: [0.0, 0.2, 0.5, 0.8, 1.0],
  );

  static const LinearGradient darkNavBarSteel = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF5A5A5A),
      Color(0xFF4A4A4A),
      Color(0xFF3A3A3A),
      Color(0xFF4A4A4A),
      Color(0xFF5A5A5A),
    ],
    stops: [0.0, 0.2, 0.5, 0.8, 1.0],
  );

  // Viewport border gradient
  static const LinearGradient viewportBorder = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB8B8B8),
      Color(0xFF8A8A8A),
      Color(0xFF6A6A6A),
      Color(0xFF8A8A8A),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  // Helper method to get appropriate gradient based on theme
  static LinearGradient getBrushedGradient(bool isDark) {
    return isDark ? 
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4A4A4A),
          Color(0xFF3A3A3A),
          Color(0xFF2A2A2A),
          Color(0xFF1A1A1A),
        ],
      ) :
      brushedHorizontal;
  }

  static RadialGradient getCircularGradient(bool isDark) {
    return isDark ? circularDark : circularBrushed;
  }
}