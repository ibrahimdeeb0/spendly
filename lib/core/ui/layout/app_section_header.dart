import 'package:spendly/general_exports.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;

  const AppSectionHeader({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: context.tokens.s4),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: scheme.onSurface.colorWithOpacity(0.7)),
            SizedBox(width: context.tokens.s8),
          ],
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: scheme.onSurface),
          ),
        ],
      ),
    );
  }
}
