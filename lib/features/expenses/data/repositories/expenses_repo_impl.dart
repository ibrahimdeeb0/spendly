import 'package:spendly/general_exports.dart';

class ExpensesRepoImpl implements ExpensesRepo {
  final ExpensesLocalDataSource ds;

  ExpensesRepoImpl(this.ds);

  Expense _toEntity(ExpenseModel m) => Expense(
    id: m.id,
    amount: m.amount,
    categoryId: m.categoryId,
    note: m.note,
    createdAt: m.createdAt,
  );

  ExpenseModel _toModel(Expense e) => ExpenseModel(
    id: e.id,
    amount: e.amount,
    categoryId: e.categoryId,
    note: e.note,
    createdAt: e.createdAt,
  );

  @override
  Future<void> addExpense(Expense expense) => ds.addExpense(_toModel(expense));

  @override
  Future<List<Expense>> getAllExpenses() async {
    final list = await ds.getAll();
    return list.map(_toEntity).toList();
  }

  @override
  Future<void> updateExpense(Expense expense) =>
      ds.updateExpense(_toModel(expense));

  @override
  Future<void> deleteExpense(String id) => ds.deleteExpense(id);

  @override
  Future<void> deleteAllExpenses() => ds.deleteAll();
}
