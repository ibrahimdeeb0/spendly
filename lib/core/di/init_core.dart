import 'package:get_it/get_it.dart';

import '../../general_exports.dart';

Future<void> initCore(GetIt sl) async {
  sl.registerLazySingleton<AppInfo>(() => PackageAppInfo());
}
