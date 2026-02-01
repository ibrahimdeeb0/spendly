import '../entities/expense.dart';
import '../repositories/expenses_repo.dart';

class UpdateExpenseUseCase {
  final ExpensesRepo repo;
  UpdateExpenseUseCase(this.repo);

  Future<void> call(Expense expense) => repo.updateExpense(expense);
}
