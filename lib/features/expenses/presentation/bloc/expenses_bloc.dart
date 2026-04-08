import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:spendly/general_exports.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final GetExpensesOverviewUseCase _getOverview;
  final GetAllExpensesUseCase _getAll;
  final WatchAllExpensesUseCase _watchAll;
  final DeleteExpenseUseCase _delete;
  final DeleteAllExpensesUseCase _deleteAll;

  StreamSubscription? _subscription;
  List<Expense> _allExpenses = const [];

  ExpensesBloc(
    this._getOverview,
    this._getAll,
    this._watchAll,
    this._delete,
    this._deleteAll,
  ) : super(const ExpensesInitial()) {
    on<ExpensesStarted>(_onStarted);
    on<ExpensesRefreshed>(_onRefreshed);
    on<ExpensesRangeChanged>(_onRangeChanged);
    on<_ExpensesUpdated>(_onExpensesUpdated);
    on<ExpenseDeleted>(_onExpenseDeleted);
    on<AllExpensesDeleted>(_onAllExpensesDeleted);
    on<_ExpensesFailed>(_onExpensesFailed);
  }

  Future<void> _onStarted(
    ExpensesStarted event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(_buildLoadingState());

    _startListening();

    try {
      final expenses = await _getAll();
      _handleExpensesLoaded(expenses, emit);
    } catch (_) {
      emit(_buildFailureState());
    }
  }

  Future<void> _onRefreshed(
    ExpensesRefreshed event,
    Emitter<ExpensesState> emit,
  ) async {
    emit(_buildLoadingState());

    try {
      final expenses = await _getAll();
      _handleExpensesLoaded(expenses, emit);
    } catch (_) {
      emit(_buildFailureState());
    }
  }

  void _onRangeChanged(
    ExpensesRangeChanged event,
    Emitter<ExpensesState> emit,
  ) {
    if (event.range == state.range) return;

    _emitStateForRange(emit, range: event.range);
  }

  void _onExpensesUpdated(_ExpensesUpdated event, Emitter<ExpensesState> emit) {
    _handleExpensesLoaded(event.expenses, emit);
  }

  Future<void> _onExpenseDeleted(
    ExpenseDeleted event,
    Emitter<ExpensesState> emit,
  ) async {
    try {
      await _delete(event.id);
    } catch (_) {
      emit(_buildFailureState());
    }
  }

  Future<void> _onAllExpensesDeleted(
    AllExpensesDeleted event,
    Emitter<ExpensesState> emit,
  ) async {
    try {
      await _deleteAll();
    } catch (_) {
      emit(_buildFailureState());
    }
  }

  void _onExpensesFailed(_ExpensesFailed event, Emitter<ExpensesState> emit) {
    emit(_buildFailureState());
  }

  void _startListening() {
    _subscription?.cancel();

    _subscription = _watchAll.callStream().listen(
      (expenses) => add(_ExpensesUpdated(expenses)),
      onError: (_) => add(const _ExpensesFailed()),
    );
  }

  void _handleExpensesLoaded(
    List<Expense> expenses,
    Emitter<ExpensesState> emit,
  ) {
    _allExpenses = expenses;
    _emitStateForRange(emit, range: state.range);
  }

  void _emitStateForRange(
    Emitter<ExpensesState> emit, {
    required ExpensesRange range,
  }) {
    try {
      final data = _buildViewData(range);
      emit(_mapExpensesToLoadedState(data));
    } catch (_) {
      emit(_buildFailureState(range: range));
    }
  }

  ExpensesLoading _buildLoadingState() {
    return ExpensesLoading(range: state.range, previousData: state.currentData);
  }

  ExpensesFailure _buildFailureState({ExpensesRange? range}) {
    return ExpensesFailure(
      error: const AppMessage.error(AppMessageKey.loadFailed),
      range: range ?? state.range,
      previousData: state.currentData,
    );
  }

  ExpensesViewData _buildViewData(ExpensesRange range) {
    final filtered = _filterByRange(_allExpenses, range);
    final overview = _getOverview(filtered);

    return ExpensesViewData(
      range: range,
      rangeTotal: overview.totalAmount,
      rangeCount: overview.totalCount,
      expensesDayGroups: overview.groups,
      topCategories: overview.topCategories,
    );
  }

  ExpensesState _mapExpensesToLoadedState(ExpensesViewData data) {
    if (!data.hasExpenses) {
      return ExpensesEmpty(data);
    }

    return ExpensesLoaded(data);
  }

  List<Expense> _filterByRange(List<Expense> items, ExpensesRange range) {
    if (items.isEmpty) return items;

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    DateTime start;

    switch (range) {
      case ExpensesRange.day:
        start = todayStart;
        break;
      case ExpensesRange.week:
        start = todayStart.subtract(Duration(days: todayStart.weekday - 1));
        break;
      case ExpensesRange.month:
        start = DateTime(now.year, now.month);
        break;
    }

    return items.where((e) => !e.createdAt.isBefore(start)).toList();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
