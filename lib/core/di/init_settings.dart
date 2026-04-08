import 'package:get_it/get_it.dart';

import '../../general_exports.dart';

Future<void> initSettings(GetIt sl) async {
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(),
  );

  sl.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImpl(
      sl<SettingsLocalDataSource>(),
      sl<ExpensesLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton(() => GetSettingsUseCase(sl<SettingsRepo>()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl<SettingsRepo>()));
  sl.registerLazySingleton(() => SetLocaleUseCase(sl<SettingsRepo>()));
  sl.registerLazySingleton(() => SetCurrencyUseCase(sl<SettingsRepo>()));
  sl.registerLazySingleton(() => ResetAllSettingsUseCase(sl<SettingsRepo>()));

  sl.registerFactory(
    () => SettingsCubit(
      sl<GetSettingsUseCase>(),
      sl<SetThemeModeUseCase>(),
      sl<SetLocaleUseCase>(),
      sl<SetCurrencyUseCase>(),
      sl<AppInfo>(),
      sl<ResetAllSettingsUseCase>(),
      sl<DeleteAllExpensesUseCase>(),
    ),
  );
}
