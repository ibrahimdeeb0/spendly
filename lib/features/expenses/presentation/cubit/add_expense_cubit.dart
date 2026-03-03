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
        paymentMethod: expense.paymentMethod,
      ),
    );
  }

  void setAmount(String input) {
    final value = double.tryParse(input.replaceAll(',', '.'));
    emit(state.copyWith(amount: value));
  }

  void setCategory(String id) {
    emit(state.copyWith(categoryId: id));
  }

  void setNote(String note) {
    emit(state.copyWith(note: note));
  }

  void setDate(DateTime date) {
    emit(state.copyWith(date: date));
  }

  void setPaymentMethod(PaymentMethod method) {
    emit(state.copyWith(paymentMethod: method));
  }

  Future<bool> submit() async {
    if (state.amount == null || state.amount! <= 0) {
      emit(
        state.copyWith(
          message: const AppMessage.error(AppMessageKey.invalidAmount),
        ),
      );
      return false;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      final expense = Expense(
        id: state.editingId ?? DateTime.now().microsecondsSinceEpoch.toString(),
        amount: state.amount!,
        categoryId: state.categoryId,
        note: state.note.trim(),
        createdAt: state.date,
        paymentMethod: state.paymentMethod,
      );

      if (state.editingId == null) {
        await _addExpense(expense);
      } else {
        await _updateExpense(expense);
      }

      emit(state.copyWith(isSubmitting: false));
      return true;
    } catch (_) {
      emit(
        state.copyWith(
          isSubmitting: false,
          message: const AppMessage.error(AppMessageKey.saveFailed),
        ),
      );
      return false;
    }
  }

  void clearMessage() => emit(state.copyWith());
}
