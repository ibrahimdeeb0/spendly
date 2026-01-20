import 'package:get_it/get_it.dart';

import '../../general_exports.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(),
  );

  // Cubits
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit(sl()));
  sl.registerLazySingleton<CurrencyCubit>(() => CurrencyCubit(sl()));

  // datasources / repositories / usecases
}
