import 'package:spendly/general_exports.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final SettingsLocalDataSource _ds;

  LocaleCubit(this._ds) : super(const LocaleState(Locale('ar')));

  Future<void> load() async {
    final code = await _ds.getLocale(); // 'ar' | 'en'
    if (code == null) return;
    emit(LocaleState(Locale(code)));
  }

  Future<void> setLocale(Locale locale) async {
    emit(LocaleState(locale));
    await _ds.setLocale(locale.languageCode);
  }

  Future<void> toggle() async {
    final isAr = state.locale.languageCode == 'ar';
    await setLocale(Locale(isAr ? 'en' : 'ar'));
  }
}
