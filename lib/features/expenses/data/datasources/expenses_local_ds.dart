import 'package:hive/hive.dart';

import '../models/expense_model.dart';

class ExpensesLocalDataSource {
  static const String boxName = 'expenses_box';
  Box<ExpenseModel>? _cachedBox;

  Future<Box<ExpenseModel>> _box() async {
    return _cachedBox ??= await Hive.openBox<ExpenseModel>(boxName);
  }

  Future<void> addExpense(ExpenseModel model) async {
    final Box<ExpenseModel> box = await _box();
    await box.put(model.id, model);
  }

  Future<List<ExpenseModel>> getAll() async {
    final box = await _box();
    return box.values.toList();
  }

  Stream<List<ExpenseModel>> watchExpenses() async* {
    final box = await _box();
    yield box.values.toList();
    yield* box.watch().map((_) => box.values.toList());
  }

  Future<void> updateExpense(ExpenseModel model) async {
    final box = await _box();
    await box.put(model.id, model);
  }

  Future<void> deleteExpense(String id) async {
    final box = await _box();
    await box.delete(id);
  }

  Future<void> deleteAll() async {
    final box = await _box();
    await box.clear();
  }
}
