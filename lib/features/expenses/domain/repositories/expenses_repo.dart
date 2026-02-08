import '../entities/expense.dart';

abstract class ExpensesRepo {
  Future<void> addExpense(Expense expense);
  Stream<List<Expense>> watchAllExpenses();
  Future<List<Expense>> getAllExpenses();
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
  Future<void> deleteAllExpenses();
}
