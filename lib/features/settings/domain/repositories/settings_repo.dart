abstract class SettingsRepo {
  Future<String?> getThemeMode(); // 'light' | 'dark'
  Future<void> setThemeMode(String value);

  Future<String?> getLocale(); // 'ar' | 'en'
  Future<void> setLocale(String value);

  Future<String?> getCurrency(); // 'USD' | 'ILS' | 'SAR'
  Future<void> setCurrency(String value);

  Future<void> resetAllData();
  Future<void> deleteAllExpenses();
}
