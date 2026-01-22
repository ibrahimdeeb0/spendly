import 'package:spendly/general_exports.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouters.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRouters.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRouters.addExpense:
        return MaterialPageRoute(builder: (_) => const AddExpensePage());

      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
