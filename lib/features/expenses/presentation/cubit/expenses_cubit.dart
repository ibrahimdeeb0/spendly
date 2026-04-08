// import 'dart:async' show StreamSubscription;
//
// import 'package:spendly/general_exports.dart';
//
// class ExpensesCubit extends Cubit<ExpensesState> {
//   final GetExpensesOverviewUseCase _getOverview;
//   final GetAllExpensesUseCase _getAll;
//   final WatchAllExpensesUseCase _watchAll;
//   final DeleteExpenseUseCase _delete;
//   final DeleteAllExpensesUseCase _deleteAll;
//
//   StreamSubscription? _subscription;
//   List<Expense> _allExpenses = const [];
//
//   ExpensesCubit(
//     this._getOverview,
//     this._getAll,
//     this._watchAll,
//     this._delete,
//     this._deleteAll,
//   ) : super(ExpensesState.initial()) {
//     _startListening();
//   }
//
//   /// Reloads expenses. Used for pull-to-refresh.
//   Future<void> load() async {
//     try {
//       final expenses = await _getAll();
//       _processData(expenses);
//     } catch (_) {
//       if (!isClosed) {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             error: const AppMessage.error(AppMessageKey.loadFailed),
//           ),
//         );
//       }
//     }
//   }
//
//   void _processData(List<Expense> expenses) {
//     _allExpenses = expenses;
//     _applyRange(state.range);
//   }
//
//   void setRange(ExpensesRange range) {
//     if (range == state.range) return;
//     emit(state.copyWith(range: range));
//     _applyRange(range);
//   }
//
//   void _applyRange(ExpensesRange range) {
//     try {
//       final filtered = _filterByRange(_allExpenses, range);
//       final overview = _getOverview(filtered);
//       emit(
//         state.copyWith(
//           isLoading: false,
//           expensesDayGroups: overview.groups,
//           rangeCount: overview.totalCount,
//           rangeTotal: overview.totalAmount,
//           topCategories: overview.topCategories,
//         ),
//       );
//     } catch (_) {
//       if (!isClosed) {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             error: const AppMessage.error(AppMessageKey.loadFailed),
//           ),
//         );
//       }
//     }
//   }
//
//   List<Expense> _filterByRange(List<Expense> items, ExpensesRange range) {
//     if (items.isEmpty) return items;
//     final now = DateTime.now();
//     final todayStart = DateTime(now.year, now.month, now.day);
//     DateTime start;
//
//     switch (range) {
//       case ExpensesRange.day:
//         start = todayStart;
//       case ExpensesRange.week:
//         final startOfWeek = todayStart.subtract(
//           Duration(days: todayStart.weekday - 1),
//         );
//         start = startOfWeek;
//       case ExpensesRange.month:
//         start = DateTime(now.year, now.month, 1);
//     }
//
//     return items.where((e) => !e.createdAt.isBefore(start)).toList();
//   }
//
//   Future<void> deleteExpense(String id) async => await _delete(id);
//
//   Future<void> deleteAll() async => await _deleteAll();
//
//   void _startListening() {
//     _subscription = _watchAll.callStream().listen(
//       (expenses) => _processData(expenses),
//       onError: (_) {
//         if (!isClosed) {
//           emit(
//             state.copyWith(
//               isLoading: false,
//               error: const AppMessage.error(AppMessageKey.loadFailed),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   Future<void> close() {
//     _subscription?.cancel();
//     return super.close();
//   }
// }
