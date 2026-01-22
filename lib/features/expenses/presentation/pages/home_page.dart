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
            onPressed: () => Navigator.pushNamed(context, AppRouters.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Center(
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
    final todayTotal = 72.47;
    final todayCount = 3;

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

  @override
  Widget build(BuildContext context) {
    final items = const [
      _CatItem('Shopping', 0.58),
      _CatItem('Food', 0.32),
      _CatItem('Transport', 0.10),
    ];

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
              child: _CategoryRow(item: e),
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
  }
}

class _CategoryRow extends StatelessWidget {
  final _CatItem item;
  const _CategoryRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(item.name, style: Theme.of(context).textTheme.bodyMedium),
        ),
        SizedBox(width: context.tokens.s12),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.tokens.rSm),
            child: LinearProgressIndicator(
              value: item.ratio,
              minHeight: 8,
              backgroundColor: scheme.surfaceContainerHighest,
            ),
          ),
        ),
        SizedBox(width: context.tokens.s12),
        Text('${(item.ratio * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}

class _ExpensesList extends StatelessWidget {
  const _ExpensesList();

  @override
  Widget build(BuildContext context) {
    final expenses = const [
      _ExpenseUi('Food', 'Whole Foods', 47.82, 'Today'),
      _ExpenseUi('Transport', 'Uber', 18.40, 'Today'),
      _ExpenseUi('Other', 'Coffee', 6.25, 'Today'),
    ];

    if (expenses.isEmpty) {
      return AppCard(
        child: Column(
          children: [
            const Icon(Icons.description_outlined, size: 48),
            SizedBox(height: context.tokens.s12),
            Text(
              context.tr.empty_expenses_title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: context.tokens.s8),
            Text(
              context.tr.empty_expenses_subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.colorWithOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return AppCard(
      child: Column(
        children: expenses
            .map(
              (e) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.circle_outlined),
                ),
                title: Text(
                  e.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  e.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Text(
                  e.amount.formatMoney(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CatItem {
  final String name;
  final double ratio;
  const _CatItem(this.name, this.ratio);
}

class _ExpenseUi {
  final String title;
  final String subtitle;
  final double amount;
  final String dayLabel;
  const _ExpenseUi(this.title, this.subtitle, this.amount, this.dayLabel);
}
