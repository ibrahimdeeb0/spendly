import '../repositories/settings_repo.dart';

class SetLocaleUseCase {
  final SettingsRepo repo;
  SetLocaleUseCase(this.repo);

  Future<void> call(String value) => repo.setLocale(value);
}
