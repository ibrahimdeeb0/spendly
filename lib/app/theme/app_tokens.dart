import 'package:flutter/material.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  final double rSm;
  final double rMd;
  final double rLg;
  final double rXl;

  final double s2;
  final double s4;
  final double s8;
  final double s12;
  final double s16;
  final double s20;
  final double s24;

  final double cardElevation;
  final Color dangerSurface;

  const AppTokens({
    required this.rSm,
    required this.rMd,
    required this.rLg,
    required this.rXl,
    required this.s2,
    required this.s4,
    required this.s8,
    required this.s12,
    required this.s16,
    required this.s20,
    required this.s24,
    required this.cardElevation,
    required this.dangerSurface,
  });

  static const AppTokens light = AppTokens(
    rSm: 10,
    rMd: 14,
    rLg: 18,
    rXl: 24,
    s2: 2,
    s4: 4,
    s8: 8,
    s12: 12,
    s16: 16,
    s20: 20,
    s24: 24,
    cardElevation: 0.6,
    dangerSurface: Color(0xFFFFEEEE),
  );

  static const AppTokens dark = AppTokens(
    rSm: 10,
    rMd: 14,
    rLg: 18,
    rXl: 24,
    s2: 2,
    s4: 4,
    s8: 8,
    s12: 12,
    s16: 16,
    s20: 20,
    s24: 24,
    cardElevation: 0.6,
    dangerSurface: Color(0xFF2A1416),
  );

  @override
  AppTokens copyWith({
    double? rSm,
    double? rMd,
    double? rLg,
    double? rXl,
    double? s2,
    double? s4,
    double? s8,
    double? s12,
    double? s16,
    double? s20,
    double? s24,
    double? cardElevation,
    Color? dangerSurface,
  }) {
    return AppTokens(
      rSm: rSm ?? this.rSm,
      rMd: rMd ?? this.rMd,
      rLg: rLg ?? this.rLg,
      rXl: rXl ?? this.rXl,
      s2: s2 ?? this.s2,
      s4: s4 ?? this.s4,
      s8: s8 ?? this.s8,
      s12: s12 ?? this.s12,
      s16: s16 ?? this.s16,
      s20: s20 ?? this.s20,
      s24: s24 ?? this.s24,
      cardElevation: cardElevation ?? this.cardElevation,
      dangerSurface: dangerSurface ?? this.dangerSurface,
    );
  }

  @override
  ThemeExtension<AppTokens> lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      rSm: lerpDouble(rSm, other.rSm, t),
      rMd: lerpDouble(rMd, other.rMd, t),
      rLg: lerpDouble(rLg, other.rLg, t),
      rXl: lerpDouble(rXl, other.rXl, t),
      s2: lerpDouble(s2, other.s2, t),
      s4: lerpDouble(s4, other.s4, t),
      s8: lerpDouble(s8, other.s8, t),
      s12: lerpDouble(s12, other.s12, t),
      s16: lerpDouble(s16, other.s16, t),
      s20: lerpDouble(s20, other.s20, t),
      s24: lerpDouble(s24, other.s24, t),
      cardElevation: lerpDouble(cardElevation, other.cardElevation, t),
      dangerSurface:
          Color.lerp(dangerSurface, other.dangerSurface, t) ?? dangerSurface,
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
