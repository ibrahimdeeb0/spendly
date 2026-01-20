import 'package:equatable/equatable.dart';

class CurrencyState extends Equatable {
  final String code; // 'USD' | 'ILS' | 'SAR'

  const CurrencyState(this.code);

  @override
  List<Object?> get props => [code];
}
