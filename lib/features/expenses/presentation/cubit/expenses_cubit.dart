import 'dart:async' show StreamSubscription;

import 'package:spendly/general_exports.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesOverviewUseCase _getOverview;
  final GetAllExpensesUseCase _getAll;
  final WatchAllExpensesUseCase _watchAll;
  final DeleteExpenseUseCase _delete;
  final DeleteAllExpensesUseCase _deleteAll;

  StreamSubscription? _subscription;

  ExpensesCubit(
    this._getOverview,
    this._getAll,
    this._watchAll,
    this._delete,
    this._deleteAll,
  ) : super(ExpensesState.initial()) {
    _startListening();
  }

  /// Reloads expenses. Used for pull-to-refresh.
  Future<void> load() async {
    try {
      final expenses = await _getAll();
      _processData(expenses);
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, error: 'LOAD_FAILED'));
      }
    }
  }

  void _processData(List<Expense> expenses) {
    try {
      final overview = _getOverview(expenses);
      emit(
        state.copyWith(
          isLoading: false,
          expensesDayGroups: overview.groups,
          todayCount: overview.todayCount,
          todayTotal: overview.todayTotal,
          topCategories: overview.topCategories,
        ),
      );
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, error: 'LOAD_FAILED'));
      }
    }
  }

  Future<void> deleteExpense(String id) async => await _delete(id);

  Future<void> deleteAll() async => await _deleteAll();

  void _startListening() {
    _subscription = _watchAll.callStream().listen(
      (expenses) => _processData(expenses),
      onError: (_) {
        if (!isClosed) {
          emit(state.copyWith(isLoading: false, error: 'LOAD_FAILED'));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
