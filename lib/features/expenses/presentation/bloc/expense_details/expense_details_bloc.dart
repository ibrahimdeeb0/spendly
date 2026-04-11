import 'package:equatable/equatable.dart';
import 'package:spendly/general_exports.dart';

part 'expense_details_event.dart';
part 'expense_details_state.dart';

class ExpenseDetailsBloc
    extends Bloc<ExpenseDetailsEvent, ExpenseDetailsState> {
  final DeleteExpenseUseCase _delete;
  ExpenseDetailsBloc(this._delete) : super(const ExpenseDetailsInitial()) {
    on<ExpenseDetailsStarted>(_onStarted);
    on<ExpenseDetailsDeletePressed>(_onDeletePressed);
  }

  void _onStarted(
    ExpenseDetailsStarted even,
    Emitter<ExpenseDetailsState> emit,
  ) {
    emit(ExpenseDetailsLoaded(even.expense));
  }

  void _onDeletePressed(
    ExpenseDetailsDeletePressed even,
    Emitter<ExpenseDetailsState> emit,
  ) async {
    final Expense? currentExpense = _currentExpense(state);

    if (currentExpense == null) return;

    emit(ExpenseDetailsDeleting(currentExpense));

    try {
      await _delete(currentExpense.id);
      emit(const ExpenseDetailsDeleteSuccess());
    } catch (_) {
      emit(
        ExpenseDetailsFailure(
          expense: currentExpense,
          message: const AppMessage.error(AppMessageKey.deleteExpensesFailed),
        ),
      );
    }
  }

  Expense? _currentExpense(ExpenseDetailsState state) {
    if (state is ExpenseDetailsLoaded) return state.expense;
    if (state is ExpenseDetailsDeleting) return state.expense;
    if (state is ExpenseDetailsFailure) return state.expense;
    return null;
  }
}
