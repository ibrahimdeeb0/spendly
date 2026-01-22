import 'package:flutter/material.dart';
import 'app_color_schemes.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData light() => _build(AppColorSchemes.light, AppTokens.light);
  static ThemeData dark() => _build(AppColorSchemes.dark, AppTokens.dark);

  static ThemeData _build(ColorScheme scheme, AppTokens tokens) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: AppTypography.buildTextTheme(scheme: scheme),
      scaffoldBackgroundColor: scheme.surface,
    );

    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[tokens],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: tokens.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.rLg),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.rMd),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.rMd),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.rMd),
          borderSide: BorderSide(color: scheme.primary, width: 1.4),
        ),
      ),
      dividerTheme: DividerThemeData(color: scheme.outline, thickness: 1),
    );
  }
}
