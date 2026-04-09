import 'package:spendly/general_exports.dart';

class ExpenseDetailsBody extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsBody({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseAmountSection(amount: expense.amount),
        SizedBox(height: context.tokens.s12),
        ExpenseMetaSection(expense: expense),
        SizedBox(height: context.tokens.s12),
        ExpenseNoteSection(note: expense.note),
        SizedBox(height: context.tokens.s12),
        ExpensePaymentMethodSection(method: expense.paymentMethod),
      ],
    );
  }
}
