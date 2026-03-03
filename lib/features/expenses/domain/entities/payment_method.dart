enum PaymentMethod { cash, wallet, transfer }

extension PaymentMethodCodec on PaymentMethod {
  String get code => name;

  static PaymentMethod fromCode(String? code) {
    switch (code) {
      case 'wallet':
        return PaymentMethod.wallet;
      case 'transfer':
        return PaymentMethod.transfer;
      case 'cash':
      default:
        return PaymentMethod.cash;
    }
  }
}
