import 'package:spendly/general_exports.dart';

import '../bloc/expenses_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ExpensesBloc>().add(const ExpensesRefreshed());
  }

  void _showErrorSnackBar(BuildContext context, AppMessage message) {
    message.show(context);
  }

  void _openSettings(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settings);
  }

  void _openAddExpense(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addExpense);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpensesBloc, ExpensesState>(
      listenWhen: (previous, current) =>
          current is ExpensesFailure && previous != current,
      listener: (context, state) {
        final failure = state as ExpensesFailure;
        _showErrorSnackBar(context, failure.error);
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
