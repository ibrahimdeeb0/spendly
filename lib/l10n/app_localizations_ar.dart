// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get currency_title => 'العملة';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language_title => 'اللغة';

  @override
  String get reset_data_title => 'إعادة تعيين البيانات';

  @override
  String get reset_data_subtitle => 'سيتم حذف جميع المصروفات المحفوظة نهائيًا';

  @override
  String get delete_all_expenses => 'حذف جميع المصروفات';

  @override
  String get app_name => 'متتبع المصروفات';

  @override
  String version(Object version) {
    return 'الإصدار $version';
  }

  @override
  String get appearance_section => 'المظهر';

  @override
  String get currency_section => 'العملة';

  @override
  String get data_section => 'البيانات';

  @override
  String get confirm_title => 'تأكيد';

  @override
  String get confirm_reset_body => 'هل أنت متأكد أنك تريد حذف جميع المصروفات؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get reset_success => 'تم حذف جميع المصروفات بنجاح.';

  @override
  String get reset_failed => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get recent_expenses => 'أحدث المصروفات';

  @override
  String get today_total => 'إجمالي اليوم';

  @override
  String transactions_count(Object Count) {
    return 'عدد العمليات $Count';
  }

  @override
  String get day => 'يوم';

  @override
  String get week => 'أسبوع';

  @override
  String get month => 'شهر';

  @override
  String get year => 'سنة';

  @override
  String get date => 'التاريخ';

  @override
  String get top_categories => 'أعلى الفئات';

  @override
  String get view_stats => 'عرض الإحصائيات';

  @override
  String get empty_expenses_title => 'لا توجد مصروفات بعد';

  @override
  String get empty_expenses_subtitle => 'أضف أول مصروف للبدء';
}
