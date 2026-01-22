import 'package:hive/hive.dart';
import '../models/expense_model.dart';

class ExpensesLocalDataSource {
  static const String boxName = 'expenses_box';

  Future<Box<ExpenseModel>> _box() async {
    return Hive.openBox<ExpenseModel>(boxName);
  }

  Future<void> addExpense(ExpenseModel model) async {
    final box = await _box();
    await box.put(model.id, model);
  }
}
