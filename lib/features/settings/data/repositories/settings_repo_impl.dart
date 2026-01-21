import '../../domain/repositories/settings_repo.dart';
import '../datasources/settings_local_ds.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsLocalDataSource ds;
  SettingsRepoImpl(this.ds);

  @override
  Future<String?> getThemeMode() => ds.getThemeMode();

  @override
  Future<void> setThemeMode(String value) => ds.setThemeMode(value);

  @override
  Future<String?> getLocale() => ds.getLocale();

  @override
  Future<void> setLocale(String value) => ds.setLocale(value);

  @override
  Future<String?> getCurrency() => ds.getCurrency();

  @override
  Future<void> setCurrency(String value) => ds.setCurrency(value);
}
