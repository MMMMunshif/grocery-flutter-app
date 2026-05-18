import 'package:flutter/material.dart';

class AppColors {
  // Main Sky Blue Theme Colors
  static const Color primaryGreen = Color(0xFF38BDF8);
  static const Color darkGreen = Color(0xFF0284C7);
  static const Color lightGreen = Color(0xFFE0F2FE);

  // Extra Blue Shades
  static const Color softBlue = Color(0xFFF0F9FF);
  static const Color mediumBlue = Color(0xFF0EA5E9);
  static const Color deepBlue = Color(0xFF0369A1);

  // Button / Highlight Color
  static const Color orange = Color(0xFFF26B21);

  // Light Mode Background Colors
  static const Color lightBackground = Color(0xFFF7FBF8);
  static const Color lightCard = Colors.white;

  // Light Mode Text Colors
  static const Color textDark = Color(0xFF111111);
  static const Color textGrey = Color(0xFF6B6B6B);

  // Dark Mode Background Colors
  static const Color darkBackground = Color(0xFF101820);
  static const Color darkCard = Color(0xFF1B2733);
  static const Color darkCardLight = Color(0xFF223447);

  // Dark Mode Text Colors
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkSubText = Color(0xFFB8C4CF);

  // Border Colors
  static const Color lightBorder = Color(0xFFE8E8E8);
  static const Color darkBorder = Color(0xFF2E3A46);

  // Common Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.redAccent;

  // Helper methods for Light/Dark Mode
  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : lightBackground;
  }

  static Color card(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCard
        : lightCard;
  }

  static Color titleText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkText
        : textDark;
  }

  static Color subtitleText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSubText
        : textGrey;
  }

  static Color border(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  static Color iconBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkGreen.withOpacity(0.18)
        : lightGreen;
  }
}