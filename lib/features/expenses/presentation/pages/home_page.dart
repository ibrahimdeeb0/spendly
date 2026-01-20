import 'package:spendly/general_exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<dynamic>(builder: (_) => SettingsPage()),
              );
            },
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}
