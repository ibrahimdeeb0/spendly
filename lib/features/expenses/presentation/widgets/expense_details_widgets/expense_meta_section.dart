import 'package:intl/intl.dart';
import 'package:spendly/general_exports.dart';

class ExpenseMetaSection extends StatelessWidget {
  final Expense expense;

  const ExpenseMetaSection({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final locale = _dateLocale(context);
    final formattedDate = DateFormat(
      'dd MMM yyyy',
      locale,
    ).format(expense.createdAt);
    final weekday = DateFormat('EEEE', locale).format(expense.createdAt);
    final categoryLabel = expense.categoryId.toCategoryLabel(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.details,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: context.tokens.s12),
          _MetaRow(
            icon: expense.categoryId.toCategoryIcon(),
            label: context.tr.category,
            value: categoryLabel,
          ),
          SizedBox(height: context.tokens.s12),
          _MetaRow(
            icon: Icons.calendar_today_outlined,
            label: context.tr.date,
            value: formattedDate,
          ),
          SizedBox(height: context.tokens.s12),
          _MetaRow(
            icon: Icons.today_outlined,
            label: context.tr.day,
            value: weekday,
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: scheme.onSurfaceVariant),
        SizedBox(width: context.tokens.s12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        SizedBox(width: context.tokens.s12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface.colorWithOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}

String _dateLocale(BuildContext context) {
  final Locale locale = Localizations.localeOf(context);
  final String tag = locale.toLanguageTag();
  if (tag.startsWith('ar')) {
    return '$tag-u-nu-latn';
  }
  return tag;
}
