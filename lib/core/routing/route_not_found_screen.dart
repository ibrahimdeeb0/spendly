import 'package:spendly/general_exports.dart';

class RouteNotFoundScreen extends StatelessWidget {
  final String? requestedLocation;

  const RouteNotFoundScreen({super.key, this.requestedLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: context.pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Route not found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              if (requestedLocation != null) ...[
                SizedBox(height: context.tokens.s8),
                Text(
                  requestedLocation!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
