part of 'add_expense_bloc.dart';

final class AddExpenseFormData extends Equatable {
  final String? editingId;
  final String amountInput;
  final String categoryId;
  final String note;
  final DateTime date;
  final PaymentMethod paymentMethod;

  const AddExpenseFormData({
    required this.editingId,
    required this.amountInput,
    required this.categoryId,
    required this.note,
    required this.date,
    required this.paymentMethod,
  });

  factory AddExpenseFormData.initial() => AddExpenseFormData(
    editingId: null,
    amountInput: '',
    categoryId: 'food',
    note: '',
    date: DateTime.now(),
    paymentMethod: PaymentMethod.cash,
  );

  factory AddExpenseFormData.fromExpense(Expense expense) => AddExpenseFormData(
    editingId: expense.id,
    amountInput: expense.amount.toString(),
    categoryId: expense.categoryId,
    note: expense.note,
    date: expense.createdAt,
    paymentMethod: expense.paymentMethod,
  );

  bool get isEditing => editingId != null;

  AddExpenseFormData copyWith({
    String? editingId,
    String? amountInput,
    String? categoryId,
    String? note,
    DateTime? date,
    PaymentMethod? paymentMethod,
  }) {
    return AddExpenseFormData(
      editingId: editingId ?? this.editingId,
      amountInput: amountInput ?? this.amountInput,
      categoryId: categoryId ?? this.categoryId,
      note: note ?? this.note,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    editingId,
    amountInput,
    categoryId,
    note,
    date,
    paymentMethod,
  ];
}

sealed class AddExpenseState extends Equatable {
  const AddExpenseState();

  AddExpenseFormData? get formData;

  @override
  List<Object?> get props => [];
}

final class AddExpenseInitial extends AddExpenseState {
  const AddExpenseInitial();

  @override
  AddExpenseFormData? get formData => null;
}

sealed class AddExpenseFormState extends AddExpenseState {
  const AddExpenseFormState(this.data);

  final AddExpenseFormData data;

  @override
  AddExpenseFormData get formData => data;

  @override
  List<Object?> get props => [data];
}

final class AddExpenseEditing extends AddExpenseFormState {
  const AddExpenseEditing(super.data);
}

final class AddExpenseSubmitting extends AddExpenseFormState {
  const AddExpenseSubmitting(super.data);
}

final class AddExpenseSuccess extends AddExpenseFormState {
  const AddExpenseSuccess(super.data);
}

final class AddExpenseFailure extends AddExpenseFormState {
  const AddExpenseFailure(super.data, {required this.message});

  final AppMessage message;

  @override
  List<Object?> get props => [data, message];
}
