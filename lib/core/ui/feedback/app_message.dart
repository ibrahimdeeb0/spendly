import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spendly/core/extensions/index.dart';
import 'package:spendly/core/ui/feedback/app_snackbar.dart';

enum AppMessageKey {
  invalidAmount,
  saveFailed,
  resetSuccess,
  resetFailed,
  deleteExpensesSuccess,
  deleteExpensesFailed,
  loadFailed,
}

class AppMessage extends Equatable {
  final AppMessageKey messageKey;
  final AppSnackBarType type;

  const AppMessage(this.messageKey, {this.type = AppSnackBarType.info});

  const AppMessage.error(this.messageKey) : type = AppSnackBarType.error;

  const AppMessage.success(this.messageKey) : type = AppSnackBarType.success;

  const AppMessage.info(this.messageKey) : type = AppSnackBarType.info;

  String resolve(BuildContext context) {
    switch (messageKey) {
      case AppMessageKey.invalidAmount:
        return context.tr.invalid_amount;
      case AppMessageKey.saveFailed:
        return context.tr.saved_failed;
      case AppMessageKey.resetSuccess:
        return context.tr.reset_data_success_message;
      case AppMessageKey.resetFailed:
        return context.tr.reset_failed;
      case AppMessageKey.deleteExpensesSuccess:
        return context.tr.delete_all_expenses_success;
      case AppMessageKey.deleteExpensesFailed:
        return context.tr.something_went_wrong;
      case AppMessageKey.loadFailed:
        return context.tr.something_went_wrong;
    }
  }

  void show(BuildContext context) {
    AppSnackBar.show(context, message: resolve(context), type: type);
  }

  @override
  List<Object?> get props => [messageKey, type];
}
