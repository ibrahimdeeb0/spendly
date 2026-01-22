import 'package:get_it/get_it.dart';

import '../../general_exports.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Settings - data
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(),
  );
  sl.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl(sl()));

  // Settings - usecases
  sl.registerLazySingleton(() => GetSettingsUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => SetLocaleUseCase(sl()));
  sl.registerLazySingleton(() => SetCurrencyUseCase(sl()));

  sl.registerLazySingleton<AppInfo>(() => PackageAppInfo());

  // Settings - cubit
  sl.registerFactory(() => SettingsCubit(sl(), sl(), sl(), sl(), sl()));
}
