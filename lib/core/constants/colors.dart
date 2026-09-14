import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand colors
  static const Color primary = Color(0xFF176B87);
  static const Color primaryDark = Color(0xFF0F4C5C);
  static const Color primaryLight = Color(0xFF86C5D8);
  static const Color accent = Color(0xFFF4A261);
  static const Color onPrimary = Colors.white;
  static const Color onAccent = Color(0xFF202124);

  // Order status colors
  static const Color statusPending = Color(0xFFF2C94C);
  static const Color statusProcess = Color(0xFF4D96FF);
  static const Color statusReady = Color(0xFF2D9CDB);
  static const Color statusDone = Color(0xFF27AE60);
  static const Color statusCancelled = Color(0xFFEB5757);

  // Feedback colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF2994A);
  static const Color error = Color(0xFFEB5757);
  static const Color info = Color(0xFF2D9CDB);

  // Neutral colors
  static const Color background = Color(0xFFF7FAFC);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1F2933);
  static const Color textSecondary = Color(0xFF667085);
  static const Color divider = Color(0xFFE4E7EC);
  static const Color disabled = Color(0xFFB8C2CC);
  static const Color border = Color(0xFFD0D5DD);
  static const Color overlay = Color(0x66000000);

  // Payment colors
  static const Color cash = Color(0xFF27AE60);
  static const Color transfer = Color(0xFF2D9CDB);
  static const Color unpaid = Color(0xFFEB5757);
  static const Color paid = Color(0xFF27AE60);
}
