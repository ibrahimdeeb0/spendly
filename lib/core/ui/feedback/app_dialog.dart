import 'package:flutter/material.dart';
import 'confirm_dialog.dart';

class AppDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget dialog,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => dialog,
    );
  }

  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    bool isDanger = false,
    IconData? icon,
    bool barrierDismissible = true,
  }) async {
    final result = await show<bool>(
      context,
      barrierDismissible: barrierDismissible,
      dialog: ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDanger: isDanger,
        icon: icon,
      ),
    );
    return result ?? false;
  }
}
