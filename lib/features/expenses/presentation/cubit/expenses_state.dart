// import 'package:equatable/equatable.dart';
// import 'package:spendly/general_exports.dart';
//
// enum ExpensesRange { day, week, month }
//
// class ExpensesState extends Equatable {
//   final bool isLoading;
//   final AppMessage? error;
//
//   final double rangeTotal;
//   final int rangeCount;
//   final ExpensesRange range;
//
//   final List<ExpensesDayGroup> expensesDayGroups;
//   final List<TopCategoryItem> topCategories;
//
//   const ExpensesState({
//     required this.isLoading,
//     required this.error,
//     required this.rangeTotal,
//     required this.rangeCount,
//     required this.range,
//     required this.expensesDayGroups,
//     required this.topCategories,
//   });
//
//   factory ExpensesState.initial() => const ExpensesState(
//     isLoading: true,
//     error: null,
//     rangeTotal: 0,
//     rangeCount: 0,
//     range: ExpensesRange.day,
//     expensesDayGroups: [],
//     topCategories: [],
//   );
//
//   ExpensesState copyWith({
//     bool? isLoading,
//     AppMessage? error,
//     double? rangeTotal,
//     int? rangeCount,
//     ExpensesRange? range,
//     List<ExpensesDayGroup>? expensesDayGroups,
//     List<TopCategoryItem>? topCategories,
//   }) {
//     return ExpensesState(
//       isLoading: isLoading ?? this.isLoading,
//       error: error,
//       rangeTotal: rangeTotal ?? this.rangeTotal,
//       rangeCount: rangeCount ?? this.rangeCount,
//       range: range ?? this.range,
//       expensesDayGroups: expensesDayGroups ?? this.expensesDayGroups,
//       topCategories: topCategories ?? this.topCategories,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     isLoading,
//     error,
//     rangeTotal,
//     rangeCount,
//     range,
//     expensesDayGroups,
//     topCategories,
//   ];
// }
