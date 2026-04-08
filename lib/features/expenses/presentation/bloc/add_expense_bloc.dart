
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc() : super(AddExpenseInitial()) {
    on<AddExpenseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
