import '../repositories/settings_repo.dart';

class SettingsSnapshot {
  final String themeMode;
  final String locale;
  final String currency;

  const SettingsSnapshot({
    required this.themeMode,
    required this.locale,
    required this.currency,
  });
}

class GetSettingsUseCase {
  final SettingsRepo repo;
  GetSettingsUseCase(this.repo);

  Future<SettingsSnapshot> call() async {
    final theme = await repo.getThemeMode() ?? 'light';
    final locale = await repo.getLocale() ?? 'ar';
    final currency = await repo.getCurrency() ?? 'USD';

    return SettingsSnapshot(
      themeMode: theme,
      locale: locale,
      currency: currency,
    );
  }
}
