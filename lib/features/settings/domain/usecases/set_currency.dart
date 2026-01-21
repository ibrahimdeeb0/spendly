import '../repositories/settings_repo.dart';

class SetCurrencyUseCase {
  final SettingsRepo repo;
  SetCurrencyUseCase(this.repo);

  Future<void> call(String value) => repo.setCurrency(value);
}
