import 'package:equatable/equatable.dart';

class AddExpenseState extends Equatable {
  final bool isSubmitting;
  final String categoryId;
  final String note;
  final DateTime date;
  final double? amount;
  final String? errorMessage;

  const AddExpenseState({
    required this.isSubmitting,
    required this.categoryId,
    required this.note,
    required this.date,
    required this.amount,
    required this.errorMessage,
  });

  factory AddExpenseState.initial() => AddExpenseState(
    isSubmitting: false,
    categoryId: 'other',
    note: '',
    date: DateTime.now(),
    amount: null,
    errorMessage: null,
  );

  AddExpenseState copyWith({
    bool? isSubmitting,
    String? categoryId,
    String? note,
    DateTime? date,
    double? amount,
    String? errorMessage,
  }) {
    return AddExpenseState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      categoryId: categoryId ?? this.categoryId,
      note: note ?? this.note,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isSubmitting,
    categoryId,
    note,
    date,
    amount,
    errorMessage,
  ];
}
