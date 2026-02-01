import 'package:spendly/general_exports.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUseCase _getSettings;
  final SetThemeModeUseCase _setTheme;
  final SetLocaleUseCase _setLocale;
  final SetCurrencyUseCase _setCurrency;
  final ResetAllSettingsUseCase _resetAllSettingsUseCase;
  final DeleteAllExpensesUseCase _deleteAllExpensesUseCase;
  final AppInfo _appInfo;

  SettingsCubit(
    this._getSettings,
    this._setTheme,
    this._setLocale,
    this._setCurrency,
    this._appInfo,
    this._resetAllSettingsUseCase,
    this._deleteAllExpensesUseCase,
  ) : super(SettingsState.initial());

  Future<void> load() async {
    final snapshot = await _getSettings();
    final version = await _appInfo.getVersionLabel();

    emit(
      state.copyWith(
        isLoading: false,
        isDark: snapshot.themeMode == 'dark',
        locale: snapshot.locale,
        currency: snapshot.currency,
        appVersion: version,
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

  // UI calls this after confirmation dialog.
  Future<void> resetAllSettings() async {
    emit(state.copyWith(isResetting: true, actionMessage: null));

    try {
      // Wire with real use case later:
      await _resetAllSettingsUseCase();

      emit(state.copyWith(isResetting: false, actionMessage: 'RESET_SUCCESS'));
    } catch (_) {
      emit(state.copyWith(isResetting: false, actionMessage: 'RESET_FAILED'));
    }
  }

  Future<void> resetExpenses() async {
    await _deleteAllExpensesUseCase();
    emit(state.copyWith(actionMessage: 'RESET_SUCCESS'));
  }

  // Call after showing snackbar to avoid repeating on rebuild.
  void clearActionMessage() {
    emit(state.copyWith(actionMessage: null));
  }
}
