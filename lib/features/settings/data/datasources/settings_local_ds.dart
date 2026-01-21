import 'package:hive/hive.dart';
import '../../../../core/constants/hive_keys.dart';

class SettingsLocalDataSource {
  Future<Box> _open() => Hive.openBox(HiveBoxes.settings);

  Future<String?> getThemeMode() async {
    final box = await _open();
    return box.get(SettingsKeys.themeMode) as String?;
  }

  Future<void> setThemeMode(String value) async {
    final box = await _open();
    await box.put(SettingsKeys.themeMode, value);
  }

  Future<String?> getLocale() async {
    final box = await _open();
    return box.get(SettingsKeys.locale) as String?;
  }

  Future<void> setLocale(String value) async {
    final box = await _open();
    await box.put(SettingsKeys.locale, value);
  }

  Future<String?> getCurrency() async {
    final box = await _open();
    return box.get(SettingsKeys.currency) as String?;
  }

  Future<void> setCurrency(String value) async {
    final box = await _open();
    await box.put(SettingsKeys.currency, value);
  }
}
