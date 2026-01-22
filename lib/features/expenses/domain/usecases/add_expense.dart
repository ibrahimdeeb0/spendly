import '../entities/expense.dart';
import '../repositories/expenses_repo.dart';

class AddExpenseUseCase {
  final ExpensesRepo repo;
  AddExpenseUseCase(this.repo);

  Future<void> call(Expense expense) => repo.addExpense(expense);
}
