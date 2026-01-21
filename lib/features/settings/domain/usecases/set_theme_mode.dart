import '../repositories/settings_repo.dart';

class SetThemeModeUseCase {
  final SettingsRepo repo;
  SetThemeModeUseCase(this.repo);

  Future<void> call(String value) => repo.setThemeMode(value);
}
