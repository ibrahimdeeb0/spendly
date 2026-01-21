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

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
              child: ListView(
                padding: context.pagePadding,
                children: [
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'العملة',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: context.tokens.s12),
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
                            SizedBox(width: context.tokens.s12),
                            Expanded(
                              child: _CurrencyBtn(
                                label: '₪',
                                isSelected: state.currency == 'ILS',
                                onTap: () => context
                                    .read<SettingsCubit>()
                                    .setCurrency('ILS'),
                              ),
                            ),
                            SizedBox(width: context.tokens.s12),
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
                  SizedBox(height: context.tokens.s12),
                  _SectionCard(
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'الوضع الليلي',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      value: state.isDark,
                      onChanged: (_) =>
                          context.read<SettingsCubit>().toggleTheme(),
                    ),
                  ),
                  SizedBox(height: context.tokens.s12),
                  _DangerCard(
                    title: 'تصفير البيانات',
                    subtitle: 'سيتم حذف جميع المصاريف المسجلة بشكل نهائي',
                    buttonText: 'حذف جميع المصاريف',
                    onTap: () {
                      // TODO: Wire this after expenses feature is ready.
                    },
                  ),
                  SizedBox(height: context.tokens.s24),
                  _Footer(),
                ],
              ),
            ),
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
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(padding: EdgeInsets.all(context.tokens.s16), child: child),
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
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.tokens.rMd),
      child: Container(
        height: context.isTablet ? 48 : 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? scheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(context.tokens.rMd),
          border: Border.all(
            color: isSelected ? scheme.primary : scheme.outline,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected ? scheme.onPrimary : scheme.onSurface,
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
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.tokens.s16),
      decoration: BoxDecoration(
        color: context.tokens.dangerSurface,
        borderRadius: BorderRadius.circular(context.tokens.rLg),
        border: Border.all(color: scheme.outline.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: context.tokens.s8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: context.tokens.s12),
          SizedBox(
            width: double.infinity,
            height: context.isTablet ? 50 : 46,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.tokens.rMd),
                ),
              ),
              child: Text(
                buttonText,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: scheme.onError),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Text(
            'تطبيق تتبع المصروفات',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: scheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(height: context.tokens.s8),
          Text(
            'الإصدار 1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: scheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
