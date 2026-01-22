import 'package:spendly/general_exports.dart';

class ExpensesRepoImpl implements ExpensesRepo {
  final ExpensesLocalDataSource ds;

  ExpensesRepoImpl(this.ds);

  @override
  Future<void> addExpense(Expense expense) async {
    final model = ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      categoryId: expense.categoryId,
      note: expense.note,
      createdAt: expense.createdAt,
    );

    await ds.addExpense(model);
  }
}
