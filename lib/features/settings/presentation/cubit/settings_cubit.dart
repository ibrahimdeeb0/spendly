import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/set_currency.dart';
import '../../domain/usecases/set_locale.dart';
import '../../domain/usecases/set_theme_mode.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUseCase _getSettings;
  final SetThemeModeUseCase _setTheme;
  final SetLocaleUseCase _setLocale;
  final SetCurrencyUseCase _setCurrency;

  SettingsCubit(
    this._getSettings,
    this._setTheme,
    this._setLocale,
    this._setCurrency,
  ) : super(SettingsState.initial());

  Future<void> load() async {
    final snapshot = await _getSettings();
    emit(
      state.copyWith(
        isLoading: false,
        isDark: snapshot.themeMode == 'dark',
        locale: snapshot.locale,
        currency: snapshot.currency,
      ),
    );
  }

  Future<void> toggleTheme() async {
    final next = !state.isDark;
    emit(state.copyWith(isDark: next));
    await _setTheme(next ? 'dark' : 'light');
  }

  Future<void> setLocale(String code) async {
    emit(state.copyWith(locale: code));
    await _setLocale(code);
  }

  Future<void> setCurrency(String code) async {
    emit(state.copyWith(currency: code));
    await _setCurrency(code);
  }
}
