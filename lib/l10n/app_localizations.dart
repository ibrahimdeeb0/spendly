import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @currency_title.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency_title;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @language_title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_title;

  /// No description provided for @reset_data_title.
  ///
  /// In en, this message translates to:
  /// **'Reset data'**
  String get reset_data_title;

  /// No description provided for @reset_data_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All saved expenses will be permanently deleted'**
  String get reset_data_subtitle;

  /// No description provided for @delete_all_expenses.
  ///
  /// In en, this message translates to:
  /// **'Delete all expenses'**
  String get delete_all_expenses;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Expense Tracker'**
  String get app_name;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(Object version);

  /// No description provided for @appearance_section.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance_section;

  /// No description provided for @currency_section.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency_section;

  /// No description provided for @data_section.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data_section;

  /// No description provided for @confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirm_title;

  /// No description provided for @confirm_reset_body.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all expenses?'**
  String get confirm_reset_body;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @reset_success.
  ///
  /// In en, this message translates to:
  /// **'All expenses deleted successfully.'**
  String get reset_success;

  /// No description provided for @reset_failed.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get reset_failed;

  /// No description provided for @recent_expenses.
  ///
  /// In en, this message translates to:
  /// **'Recent Expenses'**
  String get recent_expenses;

  /// No description provided for @today_total.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Total'**
  String get today_total;

  /// No description provided for @transactions_count.
  ///
  /// In en, this message translates to:
  /// **'Transactions {Count}'**
  String transactions_count(Object Count);

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @top_categories.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get top_categories;

  /// No description provided for @view_stats.
  ///
  /// In en, this message translates to:
  /// **'View Statistics'**
  String get view_stats;

  /// No description provided for @empty_expenses_title.
  ///
  /// In en, this message translates to:
  /// **'No expenses added yet'**
  String get empty_expenses_title;

  /// No description provided for @empty_expenses_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first expense to get started'**
  String get empty_expenses_subtitle;

  /// No description provided for @add_expense_title.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get add_expense_title;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @category_title.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category_title;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @note_hint.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get note_hint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved_success_fully.
  ///
  /// In en, this message translates to:
  /// **'Expense saved successfully'**
  String get saved_success_fully;

  /// No description provided for @saved_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save expense. Please try again.'**
  String get saved_failed;

  /// No description provided for @invalid_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalid_amount;

  /// No description provided for @cat_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get cat_food;

  /// No description provided for @cat_shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get cat_shopping;

  /// No description provided for @cat_transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get cat_transport;

  /// No description provided for @cat_bills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get cat_bills;

  /// No description provided for @cat_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get cat_other;

  /// No description provided for @date_title.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get date_title;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
