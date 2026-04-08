import 'package:spendly/general_exports.dart';

class SettingsRouteFactory {
  static Page<dynamic> buildPage(BuildContext context, GoRouterState state) {
    return AppPageFactory.buildPage(
      state: state,
      config: const RouteConfig(child: SettingsPage()),
    );
  }
}
