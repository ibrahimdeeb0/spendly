import 'package:flutter/material.dart';

import '../../extensions/context_x.dart';

class MethodChip extends StatelessWidget {
  const MethodChip({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.iconSize = 16,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.textStyle,
    this.labelPadding = EdgeInsets.zero,
  });

  final IconData icon;
  final String label;

  /// Optional tap (Chip itself isn’t tappable by default, so we wrap it)
  final VoidCallback? onTap;

  final double iconSize;
  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;

  final TextStyle? textStyle;
  final EdgeInsetsGeometry labelPadding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final chip = Chip(
      labelPadding: labelPadding,
      avatar: Icon(
        icon,
        size: iconSize,
        color: iconColor ?? scheme.onSurfaceVariant,
      ),
      label: Text(label),
      labelStyle: textStyle ?? Theme.of(context).textTheme.labelMedium,
      backgroundColor: backgroundColor ?? scheme.surfaceContainerHighest,
      side: BorderSide(color: borderColor ?? scheme.outlineVariant),
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: context.tokens.s4,
            vertical: context.tokens.s2,
          ),
    );

    if (onTap == null) return chip;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: chip,
    );
  }
}
