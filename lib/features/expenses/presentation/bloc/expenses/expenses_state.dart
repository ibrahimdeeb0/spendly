part of 'expenses_bloc.dart';

enum ExpensesRange { day, week, month }

final class ExpensesViewData extends Equatable {
  final ExpensesRange range;
  final double rangeTotal;
  final int rangeCount;
  final List<ExpensesDayGroup> expensesDayGroups;
  final List<TopCategoryItem> topCategories;

  const ExpensesViewData({
    required this.range,
    required this.rangeTotal,
    required this.rangeCount,
    required this.expensesDayGroups,
    required this.topCategories,
  });

  const ExpensesViewData.placeholder({this.range = ExpensesRange.day})
    : rangeTotal = 0,
      rangeCount = 0,
      expensesDayGroups = const [],
      topCategories = const [];

  bool get hasExpenses => expensesDayGroups.isNotEmpty;

  @override
  List<Object?> get props => [
    range,
    rangeTotal,
    rangeCount,
    expensesDayGroups,
    topCategories,
  ];
}

sealed class ExpensesState extends Equatable {
  final ExpensesRange range;

  const ExpensesState({required this.range});

  ExpensesViewData? get currentData;
}

final class ExpensesInitial extends ExpensesState {
  const ExpensesInitial() : super(range: ExpensesRange.day);

  @override
  ExpensesViewData? get currentData => null;

  @override
  List<Object?> get props => [range];
}

final class ExpensesLoading extends ExpensesState {
  final ExpensesViewData? previousData;

  const ExpensesLoading({required super.range, this.previousData});

  @override
  ExpensesViewData? get currentData => previousData;

  @override
  List<Object?> get props => [range, previousData];
}

sealed class ExpensesContentState extends ExpensesState {
  final ExpensesViewData data;

  ExpensesContentState(this.data) : super(range: data.range);

  @override
  ExpensesViewData get currentData => data;

  @override
  List<Object?> get props => [data];
}

final class ExpensesLoaded extends ExpensesContentState {
  ExpensesLoaded(super.data);
}

final class ExpensesEmpty extends ExpensesContentState {
  ExpensesEmpty(super.data);
}

final class ExpensesFailure extends ExpensesState {
  final AppMessage error;
  final ExpensesViewData? previousData;

  const ExpensesFailure({
    required this.error,
    required super.range,
    this.previousData,
  });

  @override
  ExpensesViewData? get currentData => previousData;

  @override
  List<Object?> get props => [range, error, previousData];
}

final class ExpensesDeleteSuccess extends ExpensesState {
  final String deletedExpenseId;
  final ExpensesViewData? previousData;

  const ExpensesDeleteSuccess({
    required this.deletedExpenseId,
    required super.range,
    this.previousData,
  });

  @override
  ExpensesViewData? get currentData => previousData;

  @override
  List<Object?> get props => [range, deletedExpenseId, previousData];
}
