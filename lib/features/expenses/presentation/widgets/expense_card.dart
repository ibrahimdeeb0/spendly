import 'package:spendly/general_exports.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.dayLabel,
  });

  final String title;
  final String subtitle;
  final double amount;
  final String dayLabel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.circle_outlined),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      trailing: Text(
        amount.formatMoney(context),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
