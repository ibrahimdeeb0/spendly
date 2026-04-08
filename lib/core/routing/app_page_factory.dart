import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route_type.dart';
import 'route_config.dart';
import 'route_not_found_screen.dart';

class AppPageFactory {
  static Page<dynamic> buildPage({
    required GoRouterState state,
    required RouteConfig config,
  }) {
    switch (config.routeType) {
      case AppRouteType.material:
        return MaterialPage<dynamic>(
          key: state.pageKey,
          fullscreenDialog: config.fullscreenDialog,
          child: config.child,
        );
      case AppRouteType.fade:
        return buildFadeTransitionPage(
          state: state,
          child: config.child,
          fullscreenDialog: config.fullscreenDialog,
        );
      case AppRouteType.slideFromRight:
        return buildSlideTransitionPage(
          state: state,
          child: config.child,
          fullscreenDialog: config.fullscreenDialog,
        );
      case AppRouteType.bottomSheet:
        return buildBottomSheetPage(
          state: state,
          child: config.child,
          fullscreenDialog: config.fullscreenDialog,
        );
      case AppRouteType.none:
        return NoTransitionPage<dynamic>(
          key: state.pageKey,
          child: config.child,
        );
    }
  }

  static Page<dynamic> buildErrorPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return buildPage(
      state: state,
      config: RouteConfig(
        routeType: AppRouteType.fade,
        child: RouteNotFoundScreen(requestedLocation: state.uri.toString()),
      ),
    );
  }

  static CustomTransitionPage<dynamic> buildFadeTransitionPage({
    required GoRouterState state,
    required Widget child,
    bool fullscreenDialog = false,
  }) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      fullscreenDialog: fullscreenDialog,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static CustomTransitionPage<dynamic> buildSlideTransitionPage({
    required GoRouterState state,
    required Widget child,
    bool fullscreenDialog = false,
  }) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      fullscreenDialog: fullscreenDialog,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static CustomTransitionPage<dynamic> buildBottomSheetPage({
    required GoRouterState state,
    required Widget child,
    bool fullscreenDialog = false,
  }) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      fullscreenDialog: fullscreenDialog,
      opaque: false,
      barrierDismissible: true,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
