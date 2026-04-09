import 'package:spendly/general_exports.dart';

class ExpenseDetailsPage extends StatelessWidget {
  final Expense expense;
  const ExpenseDetailsPage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ExpenseDetailsBloc>()..add(ExpenseDetailsStarted(expense)),
      child: const _ExpenseDetailsPageView(),
    );
  }
}

class _ExpenseDetailsPageView extends StatelessWidget {
  const _ExpenseDetailsPageView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseDetailsBloc, ExpenseDetailsState>(
      listener: (context, state) {
        if (state is ExpenseDetailsDeleteSuccess) {
          context.pop(true);
        }

        if (state is ExpenseDetailsFailure) {
          state.message.show(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.tr.expense_details)),
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
              child: Padding(
                padding: context.pagePadding,
                child: _buildBody(context, state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ExpenseDetailsState state) {
    if (state is ExpenseDetailsInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ExpenseDetailsLoaded) {
      return ExpenseDetailsView(
        expense: state.expense,
        isDeleting: false,
        onEditPressed: () => _onEditPressed(context, state.expense),
        onDeletePressed: () => _onDeletePressed(context),
      );
    }

    return const SizedBox.shrink();
  }

  void _onDeletePressed(BuildContext context) {
    context.read<ExpenseDetailsBloc>().add(const ExpenseDetailsDeletePressed());
  }

  Future<void> _onEditPressed(BuildContext context, Expense expense) async {
    try {
      await context.push(
        ExpensesRoutes.edit(),
        extra: AddExpenseRouteExtra(expense: expense),
      );

      if (context.mounted) context.pop();
    } catch (_) {
      if (!context.mounted) return;

      _showErrorSnackBar(
        context,
        const AppMessage.error(AppMessageKey.deleteExpensesFailed),
      );
    }
  }

  void _showErrorSnackBar(BuildContext context, AppMessage message) {
    message.show(context);
  }
}
