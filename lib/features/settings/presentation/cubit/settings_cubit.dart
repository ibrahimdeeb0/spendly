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

  Future<void> resetAllSettings() async {
    emit(state.copyWith(isResetting: true));

    try {
      await _resetAllSettingsUseCase(
        theme: 'light',
        locale: 'ar',
        currency: 'USD',
      );

      emit(
        state.copyWith(
          isDark: false,
          locale: 'ar',
          currency: 'USD',
          isResetting: false,
          actionMessage: const AppMessage.success(AppMessageKey.resetSuccess),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isResetting: false,
          actionMessage: const AppMessage.error(AppMessageKey.resetFailed),
        ),
      );
    }
  }

  Future<void> deleteAllExpenses() async {
    emit(state.copyWith(isResetting: true));
    try {
      await _deleteAllExpensesUseCase();
      emit(
        state.copyWith(
          isResetting: false,
          actionMessage: const AppMessage.success(
            AppMessageKey.deleteExpensesSuccess,
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isResetting: false,
          actionMessage: const AppMessage.error(
            AppMessageKey.deleteExpensesFailed,
          ),
        ),
      );
    }
  }

  // Call after showing snackbar to avoid repeating on rebuild.
  void clearActionMessage() {
    emit(state.copyWith());
  }
}
