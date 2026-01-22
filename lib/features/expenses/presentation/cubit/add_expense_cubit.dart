import 'package:spendly/general_exports.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseUseCase _addExpense;

  AddExpenseCubit(this._addExpense) : super(AddExpenseState.initial());

  void setAmount(String input) {
    final cleaned = input.replaceAll(',', '.').trim();
    final value = double.tryParse(cleaned);
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
    // Basic validation
    if (state.amount == null || state.amount! <= 0) {
      emit(state.copyWith(errorMessage: 'INVALID_AMOUNT'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      final expense = Expense(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        amount: state.amount!,
        categoryId: state.categoryId,
        note: state.note.trim(),
        createdAt: state.date,
      );

      await _addExpense(expense);

      emit(state.copyWith(isSubmitting: false));
      return true;
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, errorMessage: 'SAVE_FAILED'));
      return false;
    }
  }

  void clearMessage() => emit(state.copyWith(errorMessage: null));
}
