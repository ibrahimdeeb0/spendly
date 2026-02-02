import 'package:spendly/general_exports.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.category_title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: context.tokens.s12),
          BlocSelector<AddExpenseCubit, AddExpenseState, String>(
            selector: (s) => s.categoryId,
            builder: (context, categoryId) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<String>(
                  segments: [
                    ButtonSegment(
                      value: 'food',
                      label: Text(context.tr.cat_food),
                    ),
                    ButtonSegment(
                      value: 'shopping',
                      label: Text(context.tr.cat_shopping),
                    ),
                    ButtonSegment(
                      value: 'transport',
                      label: Text(context.tr.cat_transport),
                    ),
                    ButtonSegment(
                      value: 'other',
                      label: Text(context.tr.cat_other),
                    ),
                  ],
                  selected: {categoryId},
                  onSelectionChanged: (set) =>
                      context.read<AddExpenseCubit>().setCategory(set.first),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
