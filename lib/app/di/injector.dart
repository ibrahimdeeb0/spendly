import 'package:get_it/get_it.dart';

import '../../general_exports.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Settings - data
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(),
  );
  getIt.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImpl(
      getIt<SettingsLocalDataSource>(),
      getIt<ExpensesLocalDataSource>(),
    ),
  );

  // Settings - usecases
  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => SetThemeModeUseCase(getIt()));
  getIt.registerLazySingleton(() => SetLocaleUseCase(getIt()));
  getIt.registerLazySingleton(() => SetCurrencyUseCase(getIt()));

  getIt.registerLazySingleton<AppInfo>(() => PackageAppInfo());

  // Settings - cubit
  getIt.registerFactory(
    () => SettingsCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  // Expenses - data
  getIt.registerLazySingleton<ExpensesLocalDataSource>(
    () => ExpensesLocalDataSource(),
  );
  getIt.registerLazySingleton<ExpensesRepo>(() => ExpensesRepoImpl(getIt()));

  // Expenses - usecases
  getIt.registerLazySingleton(() => GetAllExpensesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddExpenseUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteExpenseUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteAllExpensesUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateExpenseUseCase(getIt()));
  getIt.registerLazySingleton(() => ResetAllSettingsUseCase(getIt()));

  // Add Expense Cubit
  getIt.registerFactory(() => ExpensesCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => AddExpenseCubit(getIt(), getIt()));
}
