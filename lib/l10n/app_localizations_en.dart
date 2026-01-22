// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get settings_title => 'Settings';

  @override
  String get currency_title => 'Currency';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get language_title => 'Language';

  @override
  String get reset_data_title => 'Reset data';

  @override
  String get reset_data_subtitle =>
      'All saved expenses will be permanently deleted';

  @override
  String get delete_all_expenses => 'Delete all expenses';

  @override
  String get app_name => 'Expense Tracker';

  @override
  String version(Object version) {
    return 'Version $version';
  }

  @override
  String get appearance_section => 'Appearance';

  @override
  String get currency_section => 'Currency';

  @override
  String get data_section => 'Data';

  @override
  String get confirm_title => 'Confirmation';

  @override
  String get confirm_reset_body =>
      'Are you sure you want to delete all expenses?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get reset_success => 'All expenses deleted successfully.';

  @override
  String get reset_failed => 'Something went wrong. Please try again.';

  @override
  String get recent_expenses => 'Recent Expenses';

  @override
  String get today_total => 'Today\'s Total';

  @override
  String transactions_count(Object Count) {
    return 'Transactions $Count';
  }

  @override
  String get day => 'Day';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get date => 'Date';

  @override
  String get top_categories => 'Top Categories';

  @override
  String get view_stats => 'View Statistics';

  @override
  String get empty_expenses_title => 'No expenses added yet';

  @override
  String get empty_expenses_subtitle => 'Add your first expense to get started';
}
