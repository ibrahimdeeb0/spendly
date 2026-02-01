import 'package:spendly/general_exports.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ExpensesCubit>()..load(),
            child: const HomePage(),
          ),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      case AppRoutes.addExpense:
        final args = settings.arguments as AddExpenseRouteArgs?;
        return MaterialPageRoute(
          builder: (_) => AddExpensePage(initialExpense: args?.expense),
        );

      default:
        return _unknownRoute();
    }
  }

  static Route<dynamic> _unknownRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Route not found'))),
    );
  }
}
