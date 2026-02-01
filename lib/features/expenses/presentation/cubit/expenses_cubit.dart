import 'package:spendly/general_exports.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetAllExpensesUseCase _getAll;
  final DeleteExpenseUseCase _delete;
  final DeleteAllExpensesUseCase _deleteAll;

  ExpensesCubit(this._getAll, this._delete, this._deleteAll)
    : super(ExpensesState.initial());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final List<Expense> expenses = await _getAll();

      // sort desc by date
      expenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final groups = _groupByDay(expenses);
      final today = DateTime.now();
      final todayKey = DateTime(today.year, today.month, today.day);

      final todayItems = expenses.where((e) {
        final d = DateTime(
          e.createdAt.year,
          e.createdAt.month,
          e.createdAt.day,
        );
        return d == todayKey;
      }).toList();

      final todayTotal = todayItems.fold<double>(0, (s, e) => s + e.amount);
      final topCats = _topCategories(expenses);

      emit(
        state.copyWith(
          isLoading: false,
          groups: groups,
          todayCount: todayItems.length,
          todayTotal: todayTotal,
          topCategories: topCats,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'LOAD_FAILED'));
    }
  }

  Future<void> deleteExpense(String id) async {
    await _delete(id);
    await load();
  }

  Future<void> deleteAll() async {
    await _deleteAll();
    await load();
  }

  List<ExpensesDayGroup> _groupByDay(List<Expense> items) {
    final map = <DateTime, List<Expense>>{};
    for (final e in items) {
      final k = DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day);
      map.putIfAbsent(k, () => []).add(e);
    }

    final keys = map.keys.toList()..sort((a, b) => b.compareTo(a));
    return keys.map((k) => ExpensesDayGroup(day: k, items: map[k]!)).toList();
  }

  List<TopCategoryItem> _topCategories(List<Expense> items) {
    if (items.isEmpty) return [];

    final totals = <String, double>{};
    for (final e in items) {
      totals[e.categoryId] = (totals[e.categoryId] ?? 0) + e.amount;
    }

    final grand = totals.values.fold<double>(0, (s, v) => s + v);
    final sorted = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final top3 = sorted.take(3).toList();
    return top3
        .map(
          (e) => TopCategoryItem(
            categoryId: e.key,
            total: e.value,
            ratio: grand == 0 ? 0 : (e.value / grand),
          ),
        )
        .toList();
  }

  String categoryLabel(BuildContext context, String id) {
    return switch (id) {
      'food' => context.tr.cat_food,
      'shopping' => context.tr.cat_shopping,
      'transport' => context.tr.cat_transport,
      _ => context.tr.cat_other,
    };
  }
}
