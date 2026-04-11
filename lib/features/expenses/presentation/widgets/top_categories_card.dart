import 'package:spendly/general_exports.dart';

import '../bloc/expenses/expenses_bloc.dart';

class TopCategoriesCard extends StatelessWidget {
  const TopCategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExpensesBloc, ExpensesState, List<TopCategoryItem>>(
      selector: (ExpensesState state) =>
          state.currentData?.topCategories ?? const [],
      builder: (BuildContext context, List<TopCategoryItem> items) {
        if (items.isEmpty) {
          return AppCard(
            child: Text(
              context.tr.no_categories_yet,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.top_categories,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: context.tokens.s12),
              for (final item in items)
                Padding(
                  padding: EdgeInsets.only(bottom: context.tokens.s12),
                  child: _TopCategoryRow(
                    name: item.categoryId.toCategoryLabel(context),
                    ratio: item.ratio,
                  ),
                ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text(context.tr.view_stats),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopCategoryRow extends StatelessWidget {
  const _TopCategoryRow({required this.name, required this.ratio});

  final String name;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(name, style: Theme.of(context).textTheme.bodyMedium),
        ),
        SizedBox(width: context.tokens.s12),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.tokens.rSm),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: scheme.surfaceContainerHighest,
            ),
          ),
        ),
        SizedBox(width: context.tokens.s12),
        Text('${(ratio * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}
