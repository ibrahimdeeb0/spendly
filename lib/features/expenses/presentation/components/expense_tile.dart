import 'package:spendly/general_exports.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final String title;
  final String subtitle;
  final IconData icon;

  const ExpenseTile({
    required this.expense,
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            expense.amount.formatMoney(context),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(width: context.tokens.s8),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'edit') {
                final updated = await Navigator.pushNamed(
                  context,
                  AppRoutes.addExpense,
                  arguments: AddExpenseRouteArgs(expense: expense),
                );

                if (updated == true && context.mounted) {
                  context.read<ExpensesCubit>().load();
                }
              } else if (v == 'delete') {
                AppSnackBar.success(
                  context,
                  context.tr.expense_deleted_successfully,
                );
                await context.read<ExpensesCubit>().deleteExpense(expense.id);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'edit', child: Text(context.tr.edit)),
              PopupMenuItem(value: 'delete', child: Text(context.tr.delete)),
            ],
          ),
        ],
      ),
    );
  }
}
