import '../entities/expense.dart';
import '../repositories/expenses_repo.dart';

class GetAllExpensesUseCase {
  final ExpensesRepo repo;
  GetAllExpensesUseCase(this.repo);

  Future<List<Expense>> call() => repo.getAllExpenses();
}
