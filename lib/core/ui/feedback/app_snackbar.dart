import 'package:spendly/general_exports.dart';

enum AppSnackBarType { success, error, info }

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(context.tokens.s16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.tokens.rMd),
          ),
          backgroundColor: _bg(context, type),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: _fg(context, type),
              fontWeight: FontWeight.w600,
            ),
          ),
          action: action,
        ),
      );
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, type: AppSnackBarType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: AppSnackBarType.error);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message);
  }

  static Color _bg(BuildContext context, AppSnackBarType type) {
    final scheme = Theme.of(context).colorScheme;

    switch (type) {
      case AppSnackBarType.success:
        return scheme.primary;
      case AppSnackBarType.error:
        return scheme.error;
      case AppSnackBarType.info:
        return scheme.surfaceContainerHighest;
    }
  }

  static Color _fg(BuildContext context, AppSnackBarType type) {
    final scheme = Theme.of(context).colorScheme;

    switch (type) {
      case AppSnackBarType.success:
        return scheme.onPrimary;
      case AppSnackBarType.error:
        return scheme.onError;
      case AppSnackBarType.info:
        return scheme.onSurface;
    }
  }
}
