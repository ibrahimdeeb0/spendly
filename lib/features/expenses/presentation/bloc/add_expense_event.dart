part of 'add_expense_bloc.dart';

sealed class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();

  @override
  List<Object?> get props => [];
}

final class AddExpenseStarted extends AddExpenseEvent {
  const AddExpenseStarted(this.expense);

  final Expense? expense;

  @override
  List<Object?> get props => [expense];
}

final class AmountChanged extends AddExpenseEvent {
  const AmountChanged(this.input);

  final String input;

  @override
  List<Object?> get props => [input];
}

final class CategoryChanged extends AddExpenseEvent {
  const CategoryChanged(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class NoteChanged extends AddExpenseEvent {
  const NoteChanged(this.note);

  final String note;

  @override
  List<Object?> get props => [note];
}

final class DateChanged extends AddExpenseEvent {
  const DateChanged(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

final class PaymentMethodChanged extends AddExpenseEvent {
  const PaymentMethodChanged(this.paymentMethod);

  final PaymentMethod paymentMethod;

  @override
  List<Object?> get props => [paymentMethod];
}

final class SubmitPressed extends AddExpenseEvent {
  const SubmitPressed();
}
