import 'package:equatable/equatable.dart';
import 'package:spendly/general_exports.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc(this._addExpense, this._updateExpense)
    : super(const AddExpenseInitial()) {
    on<AddExpenseStarted>(_onStarted);
    on<AmountChanged>(_onAmountChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<NoteChanged>(_onNoteChanged);
    on<DateChanged>(_onDateChanged);
    on<PaymentMethodChanged>(_onPaymentMethodChanged);
    on<SubmitPressed>(_onSubmitPressed);
  }

  final AddExpenseUseCase _addExpense;
  final UpdateExpenseUseCase _updateExpense;

  void _onStarted(AddExpenseStarted event, Emitter<AddExpenseState> emit) {
    emit(AddExpenseEditing(_createInitialFormData(event.expense)));
  }

  void _onAmountChanged(AmountChanged event, Emitter<AddExpenseState> emit) {
    emit(
      AddExpenseEditing(_currentFormData.copyWith(amountInput: event.input)),
    );
  }

  void _onCategoryChanged(
    CategoryChanged event,
    Emitter<AddExpenseState> emit,
  ) {
    emit(AddExpenseEditing(_currentFormData.copyWith(categoryId: event.id)));
  }

  void _onNoteChanged(NoteChanged event, Emitter<AddExpenseState> emit) {
    emit(AddExpenseEditing(_currentFormData.copyWith(note: event.note)));
  }

  void _onDateChanged(DateChanged event, Emitter<AddExpenseState> emit) {
    emit(AddExpenseEditing(_currentFormData.copyWith(date: event.date)));
  }

  void _onPaymentMethodChanged(
    PaymentMethodChanged event,
    Emitter<AddExpenseState> emit,
  ) {
    emit(
      AddExpenseEditing(
        _currentFormData.copyWith(paymentMethod: event.paymentMethod),
      ),
    );
  }

  Future<void> _onSubmitPressed(
    SubmitPressed event,
    Emitter<AddExpenseState> emit,
  ) async {
    final formData = _currentFormData;
    final amount = _parseAmount(formData.amountInput);

    if (amount == null || amount <= 0) {
      emit(
        AddExpenseFailure(
          formData,
          message: const AppMessage.error(AppMessageKey.invalidAmount),
        ),
      );
      return;
    }

    emit(AddExpenseSubmitting(formData));

    try {
      final expense = Expense(
        id:
            formData.editingId ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        amount: amount,
        categoryId: formData.categoryId,
        note: formData.note.trim(),
        createdAt: formData.date,
        paymentMethod: formData.paymentMethod,
      );

      if (formData.isEditing) {
        await _updateExpense(expense);
      } else {
        await _addExpense(expense);
      }

      emit(AddExpenseSuccess(formData));
    } catch (_) {
      emit(
        AddExpenseFailure(
          formData,
          message: const AppMessage.error(AppMessageKey.saveFailed),
        ),
      );
    }
  }

  AddExpenseFormData get _currentFormData {
    return switch (state) {
      AddExpenseFormState(:final data) => data,
      _ => AddExpenseFormData.initial(),
    };
  }

  AddExpenseFormData _createInitialFormData(Expense? expense) {
    if (expense == null) {
      return AddExpenseFormData.initial();
    }

    return AddExpenseFormData.fromExpense(expense);
  }

  double? _parseAmount(String input) {
    return double.tryParse(input.replaceAll(',', '.'));
  }
}
