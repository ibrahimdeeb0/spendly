import 'package:spendly/general_exports.dart';

class ResetAllSettingsUseCase {
  final SettingsRepo repo;

  ResetAllSettingsUseCase(this.repo);

  Future<void> call() => repo.resetAllData();
}
