import 'package:spendly/general_exports.dart';

import '../bloc/expenses_bloc.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  void _onEditExpense(BuildContext context, Expense expense) {
    Navigator.pushNamed(
      context,
      AppRoutes.addExpense,
      arguments: AddExpenseRouteArgs(expense: expense),
    );
  }

  void _onDeleteExpense(BuildContext context, Expense expense) {
    context.read<ExpensesBloc>().add(ExpenseDeleted(expense.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionHeader(
              title: context.tr.recent_expenses,
              icon: Icons.receipt_long_outlined,
            ),
            SizedBox(height: context.tokens.s12),
            _ExpensesListBody(
              state: state,
              onEditExpense: (expense) => _onEditExpense(context, expense),
              onDeleteExpense: (expense) => _onDeleteExpense(context, expense),
            ),
          ],
        );
      },
    );
  }
}

class _ExpensesListBody extends StatelessWidget {
  const _ExpensesListBody({
    required this.state,
    required this.onEditExpense,
    required this.onDeleteExpense,
  });

  final ExpensesState state;
  final ValueChanged<Expense> onEditExpense;
  final ValueChanged<Expense> onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    if (state is ExpensesInitial || state is ExpensesLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ExpensesEmpty) {
      return const EmptyCard();
    }

    if (state is ExpensesLoaded) {
      return _ExpensesDayGroups(
        groups: (state as ExpensesLoaded).data.expensesDayGroups,
        onEditExpense: onEditExpense,
        onDeleteExpense: onDeleteExpense,
      );
    }

    final data = state.currentData;
    if (data == null || data.expensesDayGroups.isEmpty) {
      return const EmptyCard();
    }

    return _ExpensesDayGroups(
      groups: data.expensesDayGroups,
      onEditExpense: onEditExpense,
      onDeleteExpense: onDeleteExpense,
    );
  }
}

class _ExpensesDayGroups extends StatelessWidget {
  const _ExpensesDayGroups({
    required this.groups,
    required this.onEditExpense,
    required this.onDeleteExpense,
  });

  final List<ExpensesDayGroup> groups;
  final ValueChanged<Expense> onEditExpense;
  final ValueChanged<Expense> onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final group in groups)
          Padding(
            padding: EdgeInsets.only(bottom: context.tokens.s12),
            child: _ExpensesDayGroupCard(
              group: group,
              onEditExpense: onEditExpense,
              onDeleteExpense: onDeleteExpense,
            ),
          ),
      ],
    );
  }
}

class _ExpensesDayGroupCard extends StatelessWidget {
  const _ExpensesDayGroupCard({
    required this.group,
    required this.onEditExpense,
    required this.onDeleteExpense,
  });

  final ExpensesDayGroup group;
  final ValueChanged<Expense> onEditExpense;
  final ValueChanged<Expense> onDeleteExpense;

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
          for (final expense in group.items)
            ExpenseTile(
              expense: expense,
              title: expense.categoryId.toCategoryLabel(context),
              note: expense.note.isEmpty ? context.tr.no_note : expense.note,
              icon: expense.categoryId.toCategoryIcon(),
              onEdit: () => onEditExpense(expense),
              onDelete: () => onDeleteExpense(expense),
            ),
        ],
      ),
    );
  }
}
