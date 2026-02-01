import 'package:spendly/general_exports.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
                    lastDate: DateTime.now().add(const Duration(days: 365)),
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
    );
  }
}
