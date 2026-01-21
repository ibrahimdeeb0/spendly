import 'package:flutter/material.dart';
import '../../app/theme/app_tokens.dart';

enum DeviceSize { phone, tablet, desktop }

extension ContextX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get w => screenSize.width;

  DeviceSize get deviceSize {
    if (w >= 1024) return DeviceSize.desktop;
    if (w >= 600) return DeviceSize.tablet;
    return DeviceSize.phone;
  }

  bool get isPhone => deviceSize == DeviceSize.phone;
  bool get isTablet => deviceSize == DeviceSize.tablet;
  bool get isDesktop => deviceSize == DeviceSize.desktop;

  // Theme tokens shortcut
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;

  // Adaptive horizontal padding for pages
  EdgeInsets get pagePadding {
    final h = isPhone ? tokens.s16 : (isTablet ? tokens.s24 : tokens.s24);
    final v = tokens.s16;
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  // grid columns based on width
  int get gridColumns {
    if (isDesktop) return 4;
    if (isTablet) return 2;
    return 1;
  }

  // Max content width (nice for tablet/desktop)
  double get contentMaxWidth {
    if (isDesktop) return 900;
    if (isTablet) return 720;
    return double.infinity;
  }
}
