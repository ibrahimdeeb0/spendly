import 'package:spendly/general_exports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'العملة',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _CurrencyBtn(
                            label: r'$',
                            isSelected: state.currency == 'USD',
                            onTap: () => context
                                .read<SettingsCubit>()
                                .setCurrency('USD'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _CurrencyBtn(
                            label: '₪',
                            isSelected: state.currency == 'ILS',
                            onTap: () => context
                                .read<SettingsCubit>()
                                .setCurrency('ILS'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _CurrencyBtn(
                            label: 'ريال',
                            isSelected: state.currency == 'SAR',
                            onTap: () => context
                                .read<SettingsCubit>()
                                .setCurrency('SAR'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'الوضع الليلي',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  value: state.isDark,
                  onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
                ),
              ),
              const SizedBox(height: 12),
              _DangerCard(
                title: 'تصفير البيانات',
                subtitle: 'سيتم حذف جميع المصاريف المسجلة بشكل نهائي',
                buttonText: 'حذف جميع المصاريف',
                onTap: () {
                  // TODO: Wire this after expenses feature is ready.
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: const [
                    Text(
                      'تطبيق تتبع المصروفات',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 6),
                    Text('الإصدار 1.0.0', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CurrencyBtn extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CurrencyBtn({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}

class _DangerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  const _DangerCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
