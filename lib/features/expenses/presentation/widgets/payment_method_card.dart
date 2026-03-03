import 'package:spendly/general_exports.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.payment_method_title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: context.tokens.s12),
          BlocSelector<AddExpenseCubit, AddExpenseState, PaymentMethod>(
            selector: (s) => s.paymentMethod,
            builder: (context, method) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<PaymentMethod>(
                  segments: [
                    ButtonSegment(
                      value: PaymentMethod.cash,
                      label: Text(context.tr.payment_method_cash),
                    ),
                    ButtonSegment(
                      value: PaymentMethod.wallet,
                      label: Text(context.tr.payment_method_wallet),
                    ),
                    ButtonSegment(
                      value: PaymentMethod.transfer,
                      label: Text(context.tr.payment_method_transfer),
                    ),
                  ],
                  selected: {method},
                  onSelectionChanged: (set) => context
                      .read<AddExpenseCubit>()
                      .setPaymentMethod(set.first),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
