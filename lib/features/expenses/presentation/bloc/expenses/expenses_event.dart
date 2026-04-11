part of 'expenses_bloc.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class ExpensesStarted extends ExpensesEvent {
  const ExpensesStarted();
}

class ExpensesRefreshed extends ExpensesEvent {
  const ExpensesRefreshed();
}

class ExpensesRangeChanged extends ExpensesEvent {
  final ExpensesRange range;

  const ExpensesRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}

class ExpenseDeleted extends ExpensesEvent {
  final String id;

  const ExpenseDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class AllExpensesDeleted extends ExpensesEvent {
  const AllExpensesDeleted();
}

class _ExpensesUpdated extends ExpensesEvent {
  final List<Expense> expenses;

  const _ExpensesUpdated(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class _ExpensesFailed extends ExpensesEvent {
  const _ExpensesFailed();
}
