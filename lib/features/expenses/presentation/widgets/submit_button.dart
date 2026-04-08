import 'package:spendly/general_exports.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddExpenseBloc, AddExpenseState, bool>(
      selector: (state) => state is AddExpenseSubmitting,
      builder: (context, loading) {
        return SizedBox(
          height: context.isTablet ? 52 : 48,
          child: ElevatedButton(
            onPressed: loading
                ? null
                : () {
                    context.read<AddExpenseBloc>().add(const SubmitPressed());
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
