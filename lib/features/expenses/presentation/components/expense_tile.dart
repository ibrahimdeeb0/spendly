import 'package:intl/intl.dart';
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
    final scheme = Theme.of(context).colorScheme;
    final locale = _dateLocale(context);

    final year = DateFormat('dd-MM-yyyy', 'en').format(expense.createdAt);
    final day = DateFormat('EEEE', locale).format(expense.createdAt);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: scheme.surfaceContainerHighest,
        child: Icon(icon, color: scheme.onSurface),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
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
      subtitle: _TileBody(
        note: subtitle,
        amountLabel: expense.amount.formatMoney(context),
        dayLabel: day,
        yearLabel: year,
        method: expense.paymentMethod,
      ),
    );
  }
}

class _TileBody extends StatelessWidget {
  final String note;
  final String amountLabel;
  final String dayLabel;
  final String yearLabel;
  final PaymentMethod method;

  const _TileBody({
    required this.note,
    required this.amountLabel,
    required this.dayLabel,
    required this.yearLabel,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    final methodLabel = _paymentMethodLabel(context, method);
    final methodIcon = _paymentMethodIcon(method);
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (note.trim().isNotEmpty)
                Text(note, style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: context.tokens.s4),
              MethodChip(icon: methodIcon, label: methodLabel),
            ],
          ),
        ),
        SizedBox(width: context.tokens.s8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amountLabel, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: context.tokens.s8),
            Text(
              dayLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurface.colorWithOpacity(0.6),
              ),
            ),
            SizedBox(height: context.tokens.s4),
            Text(
              yearLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurface.colorWithOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String _paymentMethodLabel(BuildContext context, PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cash:
      return context.tr.payment_method_cash;
    case PaymentMethod.wallet:
      return context.tr.payment_method_wallet;
    case PaymentMethod.transfer:
      return context.tr.payment_method_transfer;
  }
}

IconData _paymentMethodIcon(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cash:
      return Icons.payments_outlined;
    case PaymentMethod.wallet:
      return Icons.account_balance_wallet_outlined;
    case PaymentMethod.transfer:
      return Icons.swap_horiz;
  }
}

String _dateLocale(BuildContext context) {
  final locale = Localizations.localeOf(context);
  final tag = locale.toLanguageTag(); // e.g. "ar", "en-US"
  if (tag.startsWith('ar')) {
    return '$tag-u-nu-latn'; // Arabic day names, Latin digits
  }
  return tag;
}
