part of 'expense_details_bloc.dart';

abstract class ExpenseDetailsEvent extends Equatable {
  const ExpenseDetailsEvent();
  @override
  List<Object?> get props => [];
}

class ExpenseDetailsStarted extends ExpenseDetailsEvent {
  final Expense expense;
  const ExpenseDetailsStarted(this.expense);

  @override
  List<Object?> get props => [expense];
}

class ExpenseDetailsDeletePressed extends ExpenseDetailsEvent {
  const ExpenseDetailsDeletePressed();

  @override
  List<Object?> get props => [];
}
