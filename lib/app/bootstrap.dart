import '../general_exports.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  // if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(ExpenseModelAdapter());

  // DI init
  await configureDependencies();

  runApp(const ExpenseTrackerApp());
}
