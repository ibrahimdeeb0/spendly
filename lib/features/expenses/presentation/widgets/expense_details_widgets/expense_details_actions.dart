import 'package:spendly/general_exports.dart';

class ExpenseDetailsActions extends StatelessWidget {
  final bool isDeleting;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const ExpenseDetailsActions({
    super.key,
    required this.isDeleting,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isDeleting ? null : onEditPressed,
              icon: const Icon(Icons.edit_outlined),
              label: Text(context.tr.edit),
            ),
          ),
          SizedBox(height: context.tokens.s12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: isDeleting ? null : onDeletePressed,
              icon: isDeleting
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : const Icon(Icons.delete_outline),
              label: Text(
                isDeleting ? context.tr.deleting_expense : context.tr.delete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
