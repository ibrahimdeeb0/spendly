import 'package:spendly/general_exports.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseUseCase _addExpense;
  final UpdateExpenseUseCase _updateExpense;

  AddExpenseCubit(this._addExpense, this._updateExpense)
    : super(AddExpenseState.initial());

  void initWith(Expense? expense) {
    if (expense == null) return;

    emit(
      state.copyWith(
        editingId: expense.id,
        amount: expense.amount,
        categoryId: expense.categoryId,
        note: expense.note,
        date: expense.createdAt,
      ),
    );
  }

  void setAmount(String input) {
    final value = double.tryParse(input.replaceAll(',', '.'));
    emit(state.copyWith(amount: value, errorMessage: null));
  }

  void setCategory(String id) {
    emit(state.copyWith(categoryId: id, errorMessage: null));
  }

  void setNote(String note) {
    emit(state.copyWith(note: note, errorMessage: null));
  }

  void setDate(DateTime date) {
    emit(state.copyWith(date: date, errorMessage: null));
  }

  Future<bool> submit() async {
    if (state.amount == null || state.amount! <= 0) {
      emit(state.copyWith(errorMessage: 'INVALID_AMOUNT'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final expense = Expense(
        id: state.editingId ?? DateTime.now().microsecondsSinceEpoch.toString(),
        amount: state.amount!,
        categoryId: state.categoryId,
        note: state.note.trim(),
        createdAt: state.date,
      );

      if (state.editingId == null) {
        await _addExpense(expense);
      } else {
        await _updateExpense(expense);
      }

      emit(state.copyWith(isSubmitting: false));
      return true;
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, errorMessage: 'SAVE_FAILED'));
      return false;
    }
  }

  void clearMessage() => emit(state.copyWith(errorMessage: null));
}
