import 'package:spendly/general_exports.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key, this.initialExpense});
  final Expense? initialExpense;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddExpenseCubit>()..initWith(initialExpense),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            initialExpense == null
                ? context.tr.add_expense_title
                : context.tr.edit_expense_title,
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
            child: Padding(padding: context.pagePadding, child: const _Form()),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late final TextEditingController _amountCtrl;
  late final TextEditingController _noteCtrl;

  @override
  void initState() {
    super.initState();
    final state = context.read<AddExpenseCubit>().state;

    _amountCtrl = TextEditingController(text: state.amount?.toString() ?? '');
    _noteCtrl = TextEditingController(text: state.note);
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseCubit, AddExpenseState>(
      listenWhen: (p, c) => p.message != c.message,
      listener: (context, state) {
        final message = state.message;
        if (message == null) return;

        message.show(context);
        context.read<AddExpenseCubit>().clearMessage();
      },
      child: ListView(
        children: [
          AmountCard(controller: _amountCtrl),
          SizedBox(height: context.tokens.s12),
          const CategoryCard(),
          SizedBox(height: context.tokens.s12),
          NoteCard(controller: _noteCtrl),
          SizedBox(height: context.tokens.s12),
          const DateCard(),
          SizedBox(height: context.tokens.s16),
          const SubmitButton(),
        ],
      ),
    );
  }
}
