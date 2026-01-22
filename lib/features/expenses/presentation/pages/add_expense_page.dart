import 'package:spendly/general_exports.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddExpenseCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.tr.add_expense_title)),
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

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseCubit, AddExpenseState>(
      listenWhen: (p, c) => p.errorMessage != c.errorMessage,
      listener: (context, state) {
        if (state.errorMessage == null) return;

        final msg = switch (state.errorMessage) {
          'INVALID_AMOUNT' => context.tr.invalid_amount,
          _ => context.tr.saved_failed,
        };
        AppSnackBar.error(context, msg);
        context.read<AddExpenseCubit>().clearMessage();
      },
      child: ListView(
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.amount,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: context.tokens.s12),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: context.read<AddExpenseCubit>().setAmount,
                  decoration: InputDecoration(hintText: '0.00'),
                ),
              ],
            ),
          ),
          SizedBox(height: context.tokens.s12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.category_title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: context.tokens.s12),
                BlocSelector<AddExpenseCubit, AddExpenseState, String>(
                  selector: (s) => s.categoryId,
                  builder: (context, categoryId) {
                    return SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'food',
                          label: Text(context.tr.cat_food),
                        ),
                        ButtonSegment(
                          value: 'shopping',
                          label: Text(context.tr.cat_shopping),
                        ),
                        ButtonSegment(
                          value: 'transport',
                          label: Text(context.tr.cat_transport),
                        ),
                        ButtonSegment(
                          value: 'other',
                          label: Text(context.tr.cat_other),
                        ),
                      ],
                      selected: {categoryId},
                      onSelectionChanged: (set) => context
                          .read<AddExpenseCubit>()
                          .setCategory(set.first),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: context.tokens.s12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.note,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: context.tokens.s12),
                TextField(
                  maxLines: 3,
                  onChanged: context.read<AddExpenseCubit>().setNote,
                  decoration: InputDecoration(hintText: context.tr.note_hint),
                ),
              ],
            ),
          ),
          SizedBox(height: context.tokens.s12),
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.tr.date_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                BlocSelector<AddExpenseCubit, AddExpenseState, DateTime>(
                  selector: (s) => s.date,
                  builder: (context, date) {
                    return TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null && context.mounted) {
                          context.read<AddExpenseCubit>().setDate(picked);
                        }
                      },
                      child: Text('${date.year}-${date.month}-${date.day}'),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: context.tokens.s16),
          BlocSelector<AddExpenseCubit, AddExpenseState, bool>(
            selector: (s) => s.isSubmitting,
            builder: (context, isSubmitting) {
              return SizedBox(
                width: double.infinity,
                height: context.isTablet ? 52 : 48,
                child: ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : () async {
                          final ok = await context
                              .read<AddExpenseCubit>()
                              .submit();
                          if (!ok || !context.mounted) return;

                          AppSnackBar.success(
                            context,
                            context.tr.saved_success_fully,
                          );
                          Navigator.pop(context, true); // return success
                        },
                  child: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(context.tr.save),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
