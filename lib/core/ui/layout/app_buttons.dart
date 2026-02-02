import 'package:spendly/general_exports.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    this.onPressed,
    required this.label,
    this.isLoading = false,
    this.isDanger = false,
    this.width = double.infinity,
    this.height,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool isDanger;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isDanger ? colorScheme.error : null,
      foregroundColor: isDanger ? colorScheme.onError : null,
    );

    return SizedBox(
      width: width,
      height: height ?? (context.isTablet ? 50 : 46),
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDanger ? colorScheme.onError : colorScheme.onPrimary,
                ),
              )
            : Text(label),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.isLoading = false,
    this.isDanger = false,
    this.width = double.infinity,
    this.height,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool isDanger;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: isDanger ? colorScheme.error : null,
      side: isDanger ? BorderSide(color: colorScheme.error) : null,
    );

    return SizedBox(
      width: width,
      height: height ?? (context.isTablet ? 50 : 46),
      child: OutlinedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDanger ? colorScheme.error : colorScheme.primary,
                ),
              )
            : Text(label),
      ),
    );
  }
}
