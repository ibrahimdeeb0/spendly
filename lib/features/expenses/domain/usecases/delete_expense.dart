import '../repositories/expenses_repo.dart';

class DeleteExpenseUseCase {
  final ExpensesRepo repo;
  DeleteExpenseUseCase(this.repo);

  Future<void> call(String id) => repo.deleteExpense(id);
}
