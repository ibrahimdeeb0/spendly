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
  String get reset_expenses_data_subtitle =>
      'سيتم حذف جميع المصروفات المحفوظة نهائيًا';

  @override
  String get reset_data_success_message =>
      'تم إعادة تعيين جميع البيانات بنجاح.';

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
  String get confirm_reset_body => 'هل أنت متأكد أنك تريد حذف جميع البيانات؟';

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

  @override
  String get add_expense_title => 'إضافة مصروف';

  @override
  String get amount => 'المبلغ';

  @override
  String get category_title => 'الفئة';

  @override
  String get note => 'ملاحظة';

  @override
  String get note_hint => 'أضف مصروف';

  @override
  String get save => 'حفظ';

  @override
  String get saved_success_fully => 'تم حفظ المصروف بنجاح';

  @override
  String get saved_failed => 'فشل حفظ المصروف. يرجى المحاولة مرة أخرى.';

  @override
  String get invalid_amount => 'يرجى إدخال مبلغ صحيح';

  @override
  String get cat_food => 'الطعام';

  @override
  String get cat_shopping => 'التسوق';

  @override
  String get cat_transport => 'النقلات';

  @override
  String get cat_bills => 'الفواتير';

  @override
  String get cat_other => 'أخرى';

  @override
  String get date_title => 'اختر التاريخ';

  @override
  String get yesterday => 'أمس';

  @override
  String get today => 'اليوم';

  @override
  String get edit => 'تعديل';

  @override
  String get delete => 'حذف';

  @override
  String get no_note => 'لا توجد ملاحظة مضافة';

  @override
  String get no_categories_yet => 'لا توجد فئات بعد';

  @override
  String get edit_expense_title => 'تعديل المصروف';

  @override
  String get expense_updated_successfully => 'تم تحديث المصروف بنجاح';

  @override
  String get expense_updated_failed =>
      'فشل تحديث المصروف. يرجى المحاولة مرة أخرى.';

  @override
  String get expense_deleted_successfully => 'تم حذف المصروف بنجاح';

  @override
  String get delete_all_expenses_success => 'تم حذف جميع المصروفات بنجاح.';

  @override
  String get delete_all_expenses_failed =>
      'فشل حذف جميع المصروفات. يرجى المحاولة مرة أخرى.';

  @override
  String get something_went_wrong => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
}
