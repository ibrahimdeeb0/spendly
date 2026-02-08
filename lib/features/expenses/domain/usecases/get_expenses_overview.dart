import '../entities/expense.dart';
import '../entities/expenses_summary.dart';

class GetExpensesOverviewUseCase {
  GetExpensesOverviewUseCase();

  ExpensesOverview call(List<Expense> expenses) {
    // sort desc by date
    expenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // group by day
    final groups = _groupByDay(expenses);

    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);

    // calculate expenses for today
    final todayItems = expenses.where((e) {
      final d = DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day);
      return d == todayKey;
    }).toList();

    final todayTotal = todayItems.fold<double>(0, (s, e) => s + e.amount);
    final topCats = _topCategories(expenses);

    return ExpensesOverview(groups, todayItems.length, todayTotal, topCats);
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
}
