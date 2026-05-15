import 'package:flutter/material.dart';

abstract class ConcertTheme {
  static const accent = Color(0xFFFF9800);
  static const accentDeep = Color(0xFFF57C00);

  /// Card footer stripe from mocks.
  static const cardFooter = Color(0xFFF2EDE4);

  static const heroBlue = LinearGradient(
    colors: [
      Color(0xFF1E3A8A),
      Color(0xFF312E81),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const heroPurple = LinearGradient(
    colors: [
      Color(0xFF4C1D95),
      Color(0xFF5B21B6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
