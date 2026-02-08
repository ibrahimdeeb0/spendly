import 'package:spendly/general_exports.dart';

class AmountCard extends StatelessWidget {
  final TextEditingController controller;
  const AmountCard({super.key, required this.controller});

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
          SizedBox(height: context.tokens.s12),
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: context.read<AddExpenseCubit>().setAmount,
            decoration: const InputDecoration(hintText: '0.00'),
          ),
        ],
      ),
    );
  }
}
