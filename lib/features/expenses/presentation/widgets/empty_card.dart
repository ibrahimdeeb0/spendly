import 'package:spendly/general_exports.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          const Icon(Icons.description_outlined, size: 48),
          SizedBox(height: context.tokens.s12),
          Text(
            context.tr.empty_expenses_title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: context.tokens.s8),
          Text(
            context.tr.empty_expenses_subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.colorWithOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
