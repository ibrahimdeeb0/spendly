import '../repositories/expenses_repo.dart';

class DeleteAllExpensesUseCase {
  final ExpensesRepo repo;
  DeleteAllExpensesUseCase(this.repo);

  Future<void> call() => repo.deleteAllExpenses();
}
