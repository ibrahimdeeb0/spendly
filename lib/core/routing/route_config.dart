import 'package:flutter/widgets.dart';

import 'app_route_type.dart';

class RouteConfig {
  final Widget child;
  final AppRouteType routeType;
  final bool fullscreenDialog;

  const RouteConfig({
    required this.child,
    this.routeType = AppRouteType.material,
    this.fullscreenDialog = false,
  });
}
