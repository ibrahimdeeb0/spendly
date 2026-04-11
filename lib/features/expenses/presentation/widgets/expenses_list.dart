import 'package:spendly/general_exports.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  void _onEditExpense(BuildContext context, Expense expense) {
    context.push(
      ExpensesRoutes.edit(),
      extra: AddExpenseRouteExtra(expense: expense),
    );
  }

  Future<void> _onDeleteExpense(BuildContext context, Expense expense) async {
    final shouldDelete = await AppDialog.confirm(
      context,
      title: context.tr.confirm_title,
      message: context.tr.confirm_delete_expense_body,
      confirmText: context.tr.delete,
      cancelText: context.tr.cancel,
      isDanger: true,
      icon: Icons.warning_amber_rounded,
    );
    if (!shouldDelete || !context.mounted) return;

    context.read<ExpensesBloc>().add(ExpenseDeleted(expense.id));
  }

  Future<void> _openExpenseDetails(
    BuildContext context,
    Expense expense,
  ) async {
    final result = await context.push(
      ExpensesRoutes.details(),
      extra: ExpenseDetailsRouteExtra(expense: expense),
    );
    if (!context.mounted) return;

    final routeResult = ExpenseDetailsRouteResultExtra.tryParse(result);
    if (routeResult?.wasDeleted == true) {
      AppSnackBar.success(context, context.tr.expense_deleted_successfully);
    }
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
              onDeleteExpense: (expense) async =>
                  _onDeleteExpense(context, expense),
              onOpenDetails: (expense) async =>
                  _openExpenseDetails(context, expense),
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
    required this.onOpenDetails,
  });

  final ExpensesState state;
  final ValueChanged<Expense> onEditExpense;
  final Future<void> Function(Expense expense) onDeleteExpense;
  final Future<void> Function(Expense expense) onOpenDetails;

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
        onOpenDetails: onOpenDetails,
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
      onOpenDetails: onOpenDetails,
    );
  }
}

class _ExpensesDayGroups extends StatelessWidget {
  const _ExpensesDayGroups({
    required this.groups,
    required this.onEditExpense,
    required this.onDeleteExpense,
    required this.onOpenDetails,
  });

  final List<ExpensesDayGroup> groups;
  final ValueChanged<Expense> onEditExpense;
  final Future<void> Function(Expense expense) onDeleteExpense;
  final Future<void> Function(Expense expense) onOpenDetails;

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
              onOpenDetails: onOpenDetails,
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
    required this.onOpenDetails,
  });

  final ExpensesDayGroup group;
  final ValueChanged<Expense> onEditExpense;
  final Future<void> Function(Expense expense) onDeleteExpense;
  final Future<void> Function(Expense expense) onOpenDetails;

  @override
  Widget build(BuildContext context) {
    final title = dayTitle(context, group.day);

    return AppCard(
      padding: EdgeInsets.zero,
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
              onDelete: () async => onDeleteExpense(expense),
              onPressDetails: () async => onOpenDetails(expense),
            ),
        ],
      ),
    );
  }
}
