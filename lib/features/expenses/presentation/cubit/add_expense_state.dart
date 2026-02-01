class AddExpenseState {
  final String? editingId; // null = add, not null = edit
  final double? amount;
  final String categoryId;
  final String note;
  final DateTime date;
  final bool isSubmitting;
  final String? errorMessage;

  const AddExpenseState({
    required this.editingId,
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.date,
    required this.isSubmitting,
    required this.errorMessage,
  });

  factory AddExpenseState.initial() => AddExpenseState(
    editingId: null,
    amount: null,
    categoryId: 'food',
    note: '',
    date: DateTime.now(),
    isSubmitting: false,
    errorMessage: null,
  );

  AddExpenseState copyWith({
    String? editingId,
    double? amount,
    String? categoryId,
    String? note,
    DateTime? date,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return AddExpenseState(
      editingId: editingId ?? this.editingId,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      note: note ?? this.note,
      date: date ?? this.date,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }
}
