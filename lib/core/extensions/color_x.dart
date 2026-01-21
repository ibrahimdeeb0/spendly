import 'package:flutter/material.dart';

extension ColorWithOpacity on Color {
  Color colorWithOpacity(double val) {
    return withValues(alpha: val);
  }
}
