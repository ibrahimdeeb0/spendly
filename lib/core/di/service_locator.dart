import 'package:get_it/get_it.dart';

import 'init_core.dart';
import 'init_expenses.dart';
import 'init_settings.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await initCore(sl);
  await initExpenses(sl);
  await initSettings(sl);
}
