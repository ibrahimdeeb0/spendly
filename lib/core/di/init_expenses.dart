import 'package:get_it/get_it.dart';

import '../../general_exports.dart';

Future<void> initExpenses(GetIt sl) async {
  // DataSource
  sl.registerLazySingleton<ExpensesLocalDataSource>(
    () => ExpensesLocalDataSource(),
  );

  // Repository
  sl.registerLazySingleton<ExpensesRepo>(
    () => ExpensesRepoImpl(sl<ExpensesLocalDataSource>()),
  );

  // Usecase
  sl.registerLazySingleton(() => GetAllExpensesUseCase(sl<ExpensesRepo>()));
  sl.registerLazySingleton(() => WatchAllExpensesUseCase(sl<ExpensesRepo>()));
  sl.registerLazySingleton(() => AddExpenseUseCase(sl<ExpensesRepo>()));
  sl.registerLazySingleton(() => DeleteExpenseUseCase(sl<ExpensesRepo>()));
  sl.registerLazySingleton(() => DeleteAllExpensesUseCase(sl<ExpensesRepo>()));
  sl.registerLazySingleton(() => UpdateExpenseUseCase(sl<ExpensesRepo>()));
  sl.registerLazySingleton(() => GetExpensesOverviewUseCase());

  // Expenses Bloc
  sl.registerFactory<ExpensesBloc>(
    () => ExpensesBloc(
      sl<GetExpensesOverviewUseCase>(),
      sl<GetAllExpensesUseCase>(),
      sl<WatchAllExpensesUseCase>(),
      sl<DeleteExpenseUseCase>(),
      sl<DeleteAllExpensesUseCase>(),
    ),
  );
  // Add Expenses Bloc
  sl.registerFactory<AddExpenseBloc>(
    () => AddExpenseBloc(sl<AddExpenseUseCase>(), sl<UpdateExpenseUseCase>()),
  );
}
