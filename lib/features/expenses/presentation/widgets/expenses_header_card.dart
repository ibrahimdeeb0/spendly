import 'package:intl/intl.dart';
import 'package:spendly/general_exports.dart';

import '../bloc/expenses_bloc.dart';

class ExpensesHeaderCard extends StatelessWidget {
  const ExpensesHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ExpensesBloc,
      ExpensesState,
      ({double total, int count, ExpensesRange range})
    >(
      selector: (state) {
        final data =
            state.currentData ??
            ExpensesViewData.placeholder(range: state.range);

        return (
          total: data.rangeTotal,
          count: data.rangeCount,
          range: data.range,
        );
      },
      builder:
          (context, ({int count, ExpensesRange range, double total}) data) {
            final rangeLabel = _rangeLabel(context, data.range);
            final scheme = Theme.of(context).colorScheme;

            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderTopRow(
                    range: data.range,
                    onChanged: (range) {
                      context.read<ExpensesBloc>().add(
                        ExpensesRangeChanged(range),
                      );
                    },
                  ),
                  SizedBox(height: context.tokens.s8),
                  Text(
                    data.total.formatMoney(context),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: context.tokens.s8),
                  Text(
                    context.tr.range_total(rangeLabel),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurface.colorWithOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: context.tokens.s4),
                  Text(
                    context.tr.transactions_count(data.count),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface.colorWithOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}

class _HeaderTopRow extends StatelessWidget {
  const _HeaderTopRow({required this.range, required this.onChanged});

  final ExpensesRange range;
  final ValueChanged<ExpensesRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final date = DateFormat('EEE d MMM', locale).format(DateTime.now());
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: Theme.of(context).textTheme.titleMedium),
              Text(
                context.tr.today,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurface.colorWithOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        _RangeDropdown(range: range, onChanged: onChanged),
      ],
    );
  }
}

class _RangeDropdown extends StatelessWidget {
  const _RangeDropdown({required this.range, required this.onChanged});

  final ExpensesRange range;
  final ValueChanged<ExpensesRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.tokens.rLg),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.tokens.s12,
          vertical: context.tokens.s4,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ExpensesRange>(
            value: range,
            borderRadius: BorderRadius.circular(context.tokens.rLg),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: ExpensesRange.values
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(_rangeLabel(context, item)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;

              onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}

String _rangeLabel(BuildContext context, ExpensesRange range) {
  switch (range) {
    case ExpensesRange.day:
      return context.tr.day;
    case ExpensesRange.week:
      return context.tr.week;
    case ExpensesRange.month:
      return context.tr.month;
  }
}
