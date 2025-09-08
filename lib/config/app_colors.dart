import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDarkBlue = Color(0xFF1A237E);
  static const Color primaryMediumBlue = Color(0xFF3F51B5);
  static const Color primaryLightBlue = Color(0xFF0D47A1);
  static const Color accentYellow = Color(0xFFFFC107);
  static const Color successGreen = Colors.green;
  static const Color errorRed = Colors.red;
  static const Color white = Colors.white;

  static Color? optionBackground;
  static Color whiteOpacity(double opacity) =>
      Colors.white.withOpacity(opacity);
  static Color blackOpacity(double opacity) =>
      Colors.black.withOpacity(opacity);
}
