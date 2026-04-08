import 'package:spendly/general_exports.dart';

class AppRouter {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: ExpensesRoutes.home(),
    routes: [
      GoRoute(path: AppRoutes.root, redirect: _redirectFromRoot),
      GoRoute(
        path: ExpensesRoutes.homePath,
        pageBuilder: ExpensesRouteFactory.buildHomePage,
      ),
      GoRoute(
        path: SettingsRoutes.path,
        pageBuilder: SettingsRouteFactory.buildPage,
      ),
      GoRoute(
        path: ExpensesRoutes.addPath,
        pageBuilder: ExpensesRouteFactory.buildAddPage,
      ),
      GoRoute(
        path: ExpensesRoutes.editPath,
        pageBuilder: ExpensesRouteFactory.buildEditPage,
      ),
    ],
    errorPageBuilder: AppPageFactory.buildErrorPage,
  );

  static String _redirectFromRoot(BuildContext context, GoRouterState state) {
    return ExpensesRoutes.home();
  }
}
