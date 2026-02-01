import 'package:spendly/general_exports.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddExpenseCubit, AddExpenseState, bool>(
      selector: (s) => s.isSubmitting,
      builder: (context, loading) {
        return SizedBox(
          height: context.isTablet ? 52 : 48,
          child: ElevatedButton(
            onPressed: loading
                ? null
                : () async {
                    final ok = await context.read<AddExpenseCubit>().submit();
                    if (!ok || !context.mounted) return;

                    AppSnackBar.success(
                      context,
                      context.tr.saved_success_fully,
                    );
                    Navigator.pop(context, true); // 🔥 refresh Home
                  },
            child: loading
                ? const CircularProgressIndicator(strokeWidth: 2)
                : Text(context.tr.save),
          ),
        );
      },
    );
  }
}
