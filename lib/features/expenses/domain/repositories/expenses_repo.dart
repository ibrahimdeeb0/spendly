import '../entities/expense.dart';

abstract class ExpensesRepo {
  Future<void> addExpense(Expense expense);
}
