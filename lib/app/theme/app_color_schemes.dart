import 'package:flutter/material.dart';

class AppColorSchemes {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2F6BFF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF111827),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF111827),
    surfaceContainerHighest: Color(0xFFF3F4F6),
    outline: Color(0xFFE5E7EB),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF7AA2FF),
    onPrimary: Color(0xFF0B1220),
    secondary: Color(0xFFE5E7EB),
    onSecondary: Color(0xFF111827),
    error: Color(0xFFFF6B6B),
    onError: Color(0xFF0B1220),
    surface: Color(0xFF0B1220),
    onSurface: Color(0xFFE5E7EB),
    surfaceContainerHighest: Color(0xFF111827),
    outline: Color(0xFF253047),
  );
}
