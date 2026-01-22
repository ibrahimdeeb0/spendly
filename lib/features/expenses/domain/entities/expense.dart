class Expense {
  final String id;
  final double amount;
  final String categoryId;
  final String note;
  final DateTime createdAt;

  const Expense({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.createdAt,
  });
}
