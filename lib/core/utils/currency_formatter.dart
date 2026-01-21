import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';

class CurrencyFormatter {
  static String symbol(String code) {
    switch (code) {
      case 'ILS':
        return '₪';
      case 'SAR':
        return '﷼';
      case 'USD':
      default:
        return r'$';
    }
  }
}

extension MoneyFormatting on num {
  String formatMoney(BuildContext context, {int decimals = 2}) {
    final currencyCode = context.select((SettingsCubit c) => c.state.currency);
    final s = CurrencyFormatter.symbol(currencyCode);
    return '$s${toStringAsFixed(decimals)}';
  }
}
