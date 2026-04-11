import 'package:spendly/general_exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ExpensesBloc>().add(const ExpensesRefreshed());
  }

  void _showErrorSnackBar(BuildContext context, AppMessage message) {
    message.show(context);
  }

  void _showDeleteSuccessSnackBar(BuildContext context) {
    AppSnackBar.success(context, context.tr.expense_deleted_successfully);
  }

  void _openSettings(BuildContext context) {
    context.push(SettingsRoutes.open());
  }

  void _openAddExpense(BuildContext context) {
    context.push(ExpensesRoutes.add());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpensesBloc, ExpensesState>(
      listenWhen: (previous, ExpensesState current) =>
          current is ExpensesFailure ||
          current is ExpensesDeleteSuccess && (previous != current),
      listener: (context, ExpensesState state) {
        if (state is ExpensesFailure) {
          _showErrorSnackBar(context, state.error);
          return;
        }

        if (state is ExpensesDeleteSuccess) {
          _showDeleteSuccessSnackBar(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr.app_name),
          actions: [
            IconButton(
              onPressed: () => _openSettings(context),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openAddExpense(context),
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () => _onRefresh(context),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
              child: Padding(
                padding: context.pagePadding,
                child: const _HomeContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return context.isTablet
        ? const HomeTabletContent()
        : const HomeMobileContent();
  }
}
