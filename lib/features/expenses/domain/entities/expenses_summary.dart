import 'expense.dart';

class ExpensesDayGroup {
  final DateTime day;
  final List<Expense> items;

  ExpensesDayGroup({required this.day, required this.items});
}

class TopCategoryItem {
  final String categoryId;
  final double ratio; // 0..1
  final double total;

  TopCategoryItem({
    required this.categoryId,
    required this.ratio,
    required this.total,
  });
}

class ExpensesOverview {
  final List<ExpensesDayGroup> groups;
  final int totalCount;
  final double totalAmount;
  final List<TopCategoryItem> topCategories;

  const ExpensesOverview(
    this.groups,
    this.totalCount,
    this.totalAmount,
    this.topCategories,
  );
}
