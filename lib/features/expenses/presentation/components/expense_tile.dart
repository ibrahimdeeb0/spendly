import 'package:intl/intl.dart';
import 'package:spendly/general_exports.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final String title;
  final String note;
  final IconData icon;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseTile({
    required this.expense,
    required this.title,
    required this.note,
    required this.icon,
    required this.onEdit,
    required this.onDelete,
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
          PopupMenuButton<_ExpenseTileAction>(
            onSelected: (action) {
              switch (action) {
                case _ExpenseTileAction.edit:
                  onEdit();
                  break;
                case _ExpenseTileAction.delete:
                  onDelete();
                  break;
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: _ExpenseTileAction.edit,
                child: Text(context.tr.edit),
              ),
              PopupMenuItem(
                value: _ExpenseTileAction.delete,
                child: Text(context.tr.delete),
              ),
            ],
          ),
        ],
      ),
      subtitle: _TileBody(
        note: note,
        amountLabel: expense.amount.formatMoney(context),
        dayLabel: day,
        yearLabel: year,
        method: expense.paymentMethod,
      ),
    );
  }
}

enum _ExpenseTileAction { edit, delete }

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
  final tag = locale.toLanguageTag();
  if (tag.startsWith('ar')) {
    return '$tag-u-nu-latn';
  }
  return tag;
}
