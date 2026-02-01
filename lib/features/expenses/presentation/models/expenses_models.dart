import '../../domain/entities/expense.dart';

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
