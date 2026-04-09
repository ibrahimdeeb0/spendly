import 'package:spendly/general_exports.dart';

class ExpenseAmountSection extends StatelessWidget {
  final double amount;

  const ExpenseAmountSection({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.amount,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: context.tokens.s8),
          Text(
            amount.formatMoney(context),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
