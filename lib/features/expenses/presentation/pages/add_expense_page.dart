import 'package:spendly/general_exports.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key, this.initialExpense});
  final Expense? initialExpense;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AddExpenseBloc>()..add(AddExpenseStarted(initialExpense)),
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
    _amountCtrl = TextEditingController();
    _noteCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _syncControllers(AddExpenseFormData formData) {
    if (_amountCtrl.text != formData.amountInput) {
      _amountCtrl.value = _amountCtrl.value.copyWith(
        text: formData.amountInput,
        selection: TextSelection.collapsed(offset: formData.amountInput.length),
        composing: TextRange.empty,
      );
    }

    if (_noteCtrl.text != formData.note) {
      _noteCtrl.value = _noteCtrl.value.copyWith(
        text: formData.note,
        selection: TextSelection.collapsed(offset: formData.note.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        final formData = state.formData;
        if (formData != null) {
          _syncControllers(formData);
        }

        if (state is AddExpenseFailure) {
          state.message.show(context);
          return;
        }

        if (state is AddExpenseSuccess) {
          AppSnackBar.success(context, context.tr.saved_success_fully);
          Navigator.pop(context, true);
        }
      },
      child: ListView(
        children: [
          AmountCard(controller: _amountCtrl),
          SizedBox(height: context.tokens.s12),
          const PaymentMethodCard(),
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
