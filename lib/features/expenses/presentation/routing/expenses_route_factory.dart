import 'package:spendly/general_exports.dart';

class ExpensesRouteFactory {
  static Page<dynamic> buildHomePage(
    BuildContext context,
    GoRouterState state,
  ) {
    return AppPageFactory.buildPage(state: state, config: _resolveHome());
  }

  static Page<dynamic> buildAddPage(BuildContext context, GoRouterState state) {
    return AppPageFactory.buildPage(state: state, config: _resolveAdd());
  }

  static Page<dynamic> buildEditPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return AppPageFactory.buildPage(state: state, config: _resolveEdit(state));
  }

  static Page<dynamic> buildExpenseDetailsPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return AppPageFactory.buildPage(
      state: state,
      config: _resolveExpenseDetails(state),
    );
  }

  static RouteConfig _resolveHome() {
    return RouteConfig(
      routeType: AppRouteType.none,
      child: BlocProvider(
        create: (_) => sl<ExpensesBloc>()..add(const ExpensesStarted()),
        child: const HomePage(),
      ),
    );
  }

  static RouteConfig _resolveAdd() {
    return const RouteConfig(child: AddExpensePage());
  }

  static RouteConfig _resolveEdit(GoRouterState state) {
    final extra = AddExpenseRouteExtra.tryParse(state.extra);
    if (extra == null) {
      return RouteConfig(
        routeType: AppRouteType.fade,
        child: RouteNotFoundScreen(requestedLocation: state.uri.toString()),
      );
    }

    return RouteConfig(child: AddExpensePage(initialExpense: extra.expense));
  }

  static RouteConfig _resolveExpenseDetails(GoRouterState state) {
    final ExpenseDetailsRouteExtra? extra = ExpenseDetailsRouteExtra.tryParse(
      state.extra,
    );

    if (extra == null) {
      return RouteConfig(
        routeType: AppRouteType.fade,
        child: RouteNotFoundScreen(requestedLocation: state.uri.toString()),
      );
    }

    return RouteConfig(child: ExpenseDetailsPage(expense: extra.expense));
  }
}
