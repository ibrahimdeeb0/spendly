import '../entities/expense.dart';
import '../repositories/expenses_repo.dart';

class WatchAllExpensesUseCase {
  final ExpensesRepo repo;
  WatchAllExpensesUseCase(this.repo);

  Stream<List<Expense>> callStream() => repo.watchAllExpenses();
}
