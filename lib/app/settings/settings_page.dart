import 'package:spendly/general_exports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final localeCubit = context.read<LocaleCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text('Dark mode'),
              trailing: Switch(
                value: context.select((ThemeCubit c) => c.state.isDark),
                onChanged: (_) => themeCubit.toggle(),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Language'),
              subtitle: Text(
                context.select((LocaleCubit c) => c.state.locale.languageCode),
              ),
              trailing: ElevatedButton(
                onPressed: () => localeCubit.toggle(),
                child: const Text('Toggle'),
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                return Row(
                  children: [
                    const Text('Currency:'),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: state.code,
                      items: const [
                        DropdownMenuItem(value: 'USD', child: Text('USD (\$)')),
                        DropdownMenuItem(value: 'ILS', child: Text('ILS (₪)')),
                        DropdownMenuItem(value: 'SAR', child: Text('SAR (﷼)')),
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        context.read<CurrencyCubit>().setCurrency(v);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
