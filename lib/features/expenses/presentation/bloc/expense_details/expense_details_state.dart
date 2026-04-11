part of 'expense_details_bloc.dart';

final class ExpenseDetailsState extends Equatable {
  const ExpenseDetailsState();
  @override
  List<Object?> get props => [];
}

final class ExpenseDetailsInitial extends ExpenseDetailsState {
  const ExpenseDetailsInitial();
}

final class ExpenseDetailsLoaded extends ExpenseDetailsState {
  final Expense expense;
  const ExpenseDetailsLoaded(this.expense);

  @override
  List<Object?> get props => [expense];
}

final class ExpenseDetailsDeleting extends ExpenseDetailsState {
  final Expense expense;
  const ExpenseDetailsDeleting(this.expense);

  @override
  List<Object?> get props => [expense];
}

final class ExpenseDetailsDeleteSuccess extends ExpenseDetailsState {
  const ExpenseDetailsDeleteSuccess();
}

final class ExpenseDetailsFailure extends ExpenseDetailsState {
  final Expense expense;
  final AppMessage message;
  const ExpenseDetailsFailure({required this.expense, required this.message});

  @override
  List<Object?> get props => [expense, message];
}
