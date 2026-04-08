import 'package:equatable/equatable.dart';
import 'package:spendly/general_exports.dart';

final class AddExpenseRouteExtra extends Equatable {
  final Expense expense;

  const AddExpenseRouteExtra({required this.expense});

  static AddExpenseRouteExtra? tryParse(Object? extra) {
    return extra is AddExpenseRouteExtra ? extra : null;
  }

  @override
  List<Object?> get props => [expense];
}
