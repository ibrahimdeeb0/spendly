import 'package:spendly/l10n/app_localizations.dart';

import '../features/expenses/presentation/bloc/expenses_bloc.dart';
import '../general_exports.dart';

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>()..load(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final theme = state.isDark ? AppTheme.dark() : AppTheme.light();
          final locale = Locale(state.locale);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: theme,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: BlocProvider(
              create: (_) =>
                  getIt<ExpensesBloc>()..add(const ExpensesStarted()),
              child: const HomePage(),
            ),
          );
        },
      ),
    );
  }
}
