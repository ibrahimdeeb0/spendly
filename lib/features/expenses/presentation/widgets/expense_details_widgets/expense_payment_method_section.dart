import 'package:spendly/general_exports.dart';

class ExpensePaymentMethodSection extends StatelessWidget {
  final PaymentMethod method;

  const ExpensePaymentMethodSection({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    final label = _paymentMethodLabel(context, method);
    final icon = _paymentMethodIcon(method);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.payment_method,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: context.tokens.s12),
          MethodChip(icon: icon, label: label),
        ],
      ),
    );
  }
}

String _paymentMethodLabel(BuildContext context, PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cash:
      return context.tr.payment_method_cash;
    case PaymentMethod.wallet:
      return context.tr.payment_method_wallet;
    case PaymentMethod.transfer:
      return context.tr.payment_method_transfer;
  }
}

IconData _paymentMethodIcon(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cash:
      return Icons.payments_outlined;
    case PaymentMethod.wallet:
      return Icons.account_balance_wallet_outlined;
    case PaymentMethod.transfer:
      return Icons.swap_horiz;
  }
}
