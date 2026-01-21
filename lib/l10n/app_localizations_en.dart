// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get currencyTitle => 'Currency';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get languageTitle => 'Language';

  @override
  String get resetDataTitle => 'Reset data';

  @override
  String get resetDataSubtitle =>
      'All saved expenses will be permanently deleted';

  @override
  String get deleteAllExpenses => 'Delete all expenses';

  @override
  String get appName => 'Expense Tracker';

  @override
  String version(Object version) {
    return 'Version $version';
  }
}
