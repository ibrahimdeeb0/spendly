import 'package:spendly/general_exports.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsLocalDataSource ds;
  final ExpensesLocalDataSource expensesDs;

  SettingsRepoImpl(this.ds, this.expensesDs);

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

  @override
  Future<void> deleteAllExpenses() => expensesDs.deleteAll();

  @override
  Future<void> resetAllData() {
    return Future.wait([
      deleteAllExpenses(),
      ds.setThemeMode('light'),
      ds.setLocale('en'),
      ds.setCurrency('USD'),
    ]);
  }
}
