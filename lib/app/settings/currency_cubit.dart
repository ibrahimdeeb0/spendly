import 'package:flutter_bloc/flutter_bloc.dart';
import 'currency_state.dart';
import 'settings_local_ds.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final SettingsLocalDataSource _ds;

  CurrencyCubit(this._ds) : super(const CurrencyState('USD'));

  Future<void> load() async {
    final saved = await _ds.getCurrency();
    if (saved == null) return;
    emit(CurrencyState(saved));
  }

  Future<void> setCurrency(String code) async {
    emit(CurrencyState(code));
    await _ds.setCurrency(code);
  }
}
