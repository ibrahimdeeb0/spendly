import 'package:spendly/general_exports.dart';

class ExpenseDetailsView extends StatelessWidget {
  final Expense expense;
  final bool isDeleting;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const ExpenseDetailsView({
    super.key,
    required this.expense,
    required this.isDeleting,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpenseDetailsBody(expense: expense),
        SizedBox(height: context.tokens.s16),
        ExpenseDetailsActions(
          isDeleting: isDeleting,
          onEditPressed: onEditPressed,
          onDeletePressed: onDeletePressed,
        ),
      ],
    );
  }
}
