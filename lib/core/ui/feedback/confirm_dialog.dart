import 'package:spendly/general_exports.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool isDanger;
  final IconData? icon;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    this.isDanger = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.tokens.rLg),
      ),
      titlePadding: EdgeInsets.fromLTRB(
        context.tokens.s16,
        context.tokens.s16,
        context.tokens.s16,
        0,
      ),
      contentPadding: EdgeInsets.fromLTRB(
        context.tokens.s16,
        context.tokens.s12,
        context.tokens.s16,
        0,
      ),
      actionsPadding: EdgeInsets.all(context.tokens.s12),
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: isDanger ? scheme.error : scheme.primary),
            SizedBox(width: context.tokens.s8),
          ],
          Expanded(child: Text(title, style: titleStyle)),
        ],
      ),
      content: Text(
        message,
        style: bodyStyle?.copyWith(
          color: scheme.onSurface.colorWithOpacity(0.75),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText),
        ),
        SizedBox(
          height: 44,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDanger ? scheme.error : scheme.primary,
              foregroundColor: isDanger ? scheme.onError : scheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.tokens.rMd),
              ),
            ),
            child: Text(confirmText),
          ),
        ),
      ],
    );
  }
}
