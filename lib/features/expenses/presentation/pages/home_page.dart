import 'package:intl/intl.dart';
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
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addExpense),
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
        const _HeaderCard(),
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
              const _HeaderCard(),
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

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      buildWhen: (oldState, newState) =>
          oldState.rangeTotal != newState.rangeTotal ||
          oldState.rangeCount != newState.rangeCount ||
          oldState.range != newState.range,
      builder: (context, state) {
        final rangeTotal = state.rangeTotal;
        final rangeCount = state.rangeCount;
        final rangeLabel = _rangeLabel(context, state.range);
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderTopRow(
                range: state.range,
                onChanged: (r) => context.read<ExpensesCubit>().setRange(r),
              ),
              SizedBox(height: context.tokens.s8),
              Text(
                rangeTotal.formatMoney(context),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: context.tokens.s8),
              Text(
                context.tr.range_total(rangeLabel),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.colorWithOpacity(0.7),
                ),
              ),
              SizedBox(height: context.tokens.s4),
              Text(
                context.tr.transactions_count(rangeCount),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.colorWithOpacity(0.6),
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
  final ExpensesRange range;
  final ValueChanged<ExpensesRange> onChanged;

  const _HeaderTopRow({required this.range, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();
    final date = DateFormat('EEE d MMM', locale).format(now);

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
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.colorWithOpacity(0.6),
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
  final ExpensesRange range;
  final ValueChanged<ExpensesRange> onChanged;

  const _RangeDropdown({required this.range, required this.onChanged});

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
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(_rangeLabel(context, r)),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
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

class _TopCategoriesCard extends StatelessWidget {
  const _TopCategoriesCard();

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
                    name: e.categoryId.toCategoryLabel(context),
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
          oldState.expensesDayGroups != newState.expensesDayGroups,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.expensesDayGroups.isEmpty) {
          return const EmptyCard();
        }

        return Column(
          children: state.expensesDayGroups
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
              title: e.categoryId.toCategoryLabel(context),
              subtitle: e.note.isEmpty ? context.tr.no_note : e.note,
              icon: e.categoryId.toCategoryIcon(),
            ),
          ),
        ],
      ),
    );
  }
}
