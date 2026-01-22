import 'package:flutter/material.dart';

extension SpacingExtension on num {
  /// Creates a vertical space with the given height.
  SizedBox get spacingVertical => SizedBox(height: toDouble());

  /// Creates a horizontal space with the given width.
  SizedBox get spacingHorizontal => SizedBox(width: toDouble());

  /// Creates a square space with the given size.
  SizedBox get square => SizedBox(width: toDouble(), height: toDouble());
}

extension Sizing on BuildContext {
  /// Returns the screen size of the device.
  double screenFlexHeight() => MediaQuery.sizeOf(this).height;

  /// Returns the screen size of the device.
  double screenFlexWidth() => MediaQuery.sizeOf(this).width;

  /// Returns screen height as int
  int screenFlexHeightInt() => MediaQuery.sizeOf(this).height.toInt();
}
