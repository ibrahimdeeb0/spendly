import 'package:spendly/general_exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.app_name),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, AppRoutes.settings);

              if (!context.mounted) return;
              context.read<ExpensesCubit>().load();
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await Navigator.pushNamed(
            context,
            AppRoutes.addExpense,
          );

          if (added == true && context.mounted) {
            context.read<ExpensesCubit>().load();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => context.read<ExpensesCubit>().load(),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
            child: Padding(
              padding: context.pagePadding,
              child: context.isTablet
                  ? const _TabletLayout()
                  : const _MobileLayout(),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _SummaryCard(),
        SizedBox(height: context.tokens.s16),
        const _TopCategoriesCard(),
        SizedBox(height: context.tokens.s20),
        AppSectionHeader(
          title: context.tr.recent_expenses,
          icon: Icons.receipt_long_outlined,
        ),
        SizedBox(height: context.tokens.s12),
        const _ExpensesList(),
      ],
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: ListView(
            children: [
              const _SummaryCard(),
              SizedBox(height: context.tokens.s16),
              const _TopCategoriesCard(),
            ],
          ),
        ),
        SizedBox(width: context.tokens.s16),
        Expanded(
          flex: 7,
          child: ListView(
            children: [
              AppSectionHeader(
                title: context.tr.recent_expenses,
                icon: Icons.receipt_long_outlined,
              ),
              SizedBox(height: context.tokens.s12),
              const _ExpensesList(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExpensesCubit, ExpensesState, (double, int)>(
      selector: (state) => (state.todayTotal, state.todayCount),
      builder: (context, state) {
        final todayTotal = state.$1;
        final todayCount = state.$2;
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.today_total,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.colorWithOpacity(0.7),
                ),
              ),
              SizedBox(height: context.tokens.s8),
              Text(
                todayTotal.formatMoney(context),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: context.tokens.s8),
              Text(
                context.tr.transactions_count(todayCount),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.colorWithOpacity(0.6),
                ),
              ),
              SizedBox(height: context.tokens.s16),
              _RangeChips(selected: 'day', onChanged: (v) {}),
            ],
          ),
        );
      },
    );
  }
}

class _RangeChips extends StatelessWidget {
  final String selected; // day/week/month
  final ValueChanged<String> onChanged;

  const _RangeChips({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: [
        ButtonSegment(value: 'day', label: Text(context.tr.day)),
        ButtonSegment(value: 'week', label: Text(context.tr.week)),
        ButtonSegment(value: 'month', label: Text(context.tr.month)),
      ],
      selected: {selected},
      onSelectionChanged: (set) => onChanged(set.first),
    );
  }
}

class _TopCategoriesCard extends StatelessWidget {
  const _TopCategoriesCard();

  String _label(BuildContext context, String id) {
    return switch (id) {
      'food' => context.tr.cat_food,
      'shopping' => context.tr.cat_shopping,
      'transport' => context.tr.cat_transport,
      _ => context.tr.cat_other,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExpensesCubit, ExpensesState, List<TopCategoryItem>>(
      selector: (state) => state.topCategories,
      builder: (context, items) {
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
              ...items.map(
                (e) => Padding(
                  padding: EdgeInsets.only(bottom: context.tokens.s12),
                  child: _TopCategoryRow(
                    name: _label(context, e.categoryId),
                    ratio: e.ratio,
                  ),
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
  final String name;
  final double ratio;

  const _TopCategoryRow({required this.name, required this.ratio});

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

class _ExpensesList extends StatelessWidget {
  const _ExpensesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      buildWhen: (oldState, newState) =>
          oldState.isLoading != newState.isLoading ||
          oldState.groups != newState.groups,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.groups.isEmpty) {
          return const EmptyCard();
        }

        return Column(
          children: state.groups
              .map(
                (g) => Padding(
                  padding: EdgeInsets.only(bottom: context.tokens.s12),
                  child: _DayGroupCard(group: g),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _DayGroupCard extends StatelessWidget {
  final ExpensesDayGroup group;
  const _DayGroupCard({required this.group});

  String _categoryLabel(BuildContext context, String id) {
    return switch (id) {
      'food' => context.tr.cat_food,
      'shopping' => context.tr.cat_shopping,
      'transport' => context.tr.cat_transport,
      _ => context.tr.cat_other,
    };
  }

  IconData _categoryIcon(String id) {
    return switch (id) {
      'food' => Icons.restaurant_outlined,
      'shopping' => Icons.shopping_bag_outlined,
      'transport' => Icons.directions_car_filled_outlined,
      _ => Icons.category_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final title = dayTitle(context, group.day);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: context.tokens.s8),
          const Divider(height: 1),
          SizedBox(height: context.tokens.s8),

          ...group.items.map(
            (e) => ExpenseTile(
              expense: e,
              title: _categoryLabel(context, e.categoryId),
              subtitle: e.note.isEmpty ? context.tr.no_note : e.note,
              icon: _categoryIcon(e.categoryId),
            ),
          ),
        ],
      ),
    );
  }
}
