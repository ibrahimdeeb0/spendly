import 'package:spendly/general_exports.dart';

class ResetAllSettingsUseCase {
  final SettingsRepo repo;

  ResetAllSettingsUseCase(this.repo);

  Future<void> call({
    required String theme,
    required String locale,
    required String currency,
  }) async {
    await repo.resetAllData(theme: theme, locale: locale, currency: currency);
  }
}
