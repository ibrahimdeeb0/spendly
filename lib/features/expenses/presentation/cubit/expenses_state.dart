import 'package:equatable/equatable.dart';
import 'package:spendly/general_exports.dart';

class ExpensesState extends Equatable {
  final bool isLoading;
  final String? error;

  final double todayTotal;
  final int todayCount;

  final List<ExpensesDayGroup> expensesDayGroups;
  final List<TopCategoryItem> topCategories;

  const ExpensesState({
    required this.isLoading,
    required this.error,
    required this.todayTotal,
    required this.todayCount,
    required this.expensesDayGroups,
    required this.topCategories,
  });

  factory ExpensesState.initial() => const ExpensesState(
    isLoading: true,
    error: null,
    todayTotal: 0,
    todayCount: 0,
    expensesDayGroups: [],
    topCategories: [],
  );

  ExpensesState copyWith({
    bool? isLoading,
    String? error,
    double? todayTotal,
    int? todayCount,
    List<ExpensesDayGroup>? expensesDayGroups,
    List<TopCategoryItem>? topCategories,
  }) {
    return ExpensesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      todayTotal: todayTotal ?? this.todayTotal,
      todayCount: todayCount ?? this.todayCount,
      expensesDayGroups: expensesDayGroups ?? this.expensesDayGroups,
      topCategories: topCategories ?? this.topCategories,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    todayTotal,
    todayCount,
    expensesDayGroups,
    topCategories,
  ];
}
