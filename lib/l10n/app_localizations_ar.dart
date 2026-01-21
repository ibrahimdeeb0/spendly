// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get currencyTitle => 'العملة';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get languageTitle => 'اللغة';

  @override
  String get resetDataTitle => 'تصفير البيانات';

  @override
  String get resetDataSubtitle => 'سيتم حذف جميع المصاريف المسجلة بشكل نهائي';

  @override
  String get deleteAllExpenses => 'حذف جميع المصاريف';

  @override
  String get appName => 'تطبيق تتبع المصروفات';

  @override
  String version(Object version) {
    return 'الإصدار $version';
  }
}
