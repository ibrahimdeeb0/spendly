import '../general_exports.dart';
import 'di/injector.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();

  // DI init
  await configureDependencies();

  runApp(const ExpenseTrackerApp());
}
