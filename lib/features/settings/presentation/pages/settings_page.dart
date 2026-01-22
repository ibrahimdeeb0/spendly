import 'package:spendly/general_exports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr.settings_title)),
      body: BlocListener<SettingsCubit, SettingsState>(
        listenWhen: (prev, curr) => prev.actionMessage != curr.actionMessage,
        listener: (context, state) {
          if (state.actionMessage == null) return;

          final msg = switch (state.actionMessage) {
            'RESET_SUCCESS' => context.tr.reset_success,
            _ => context.tr.reset_failed,
          };

          if (state.actionMessage == 'RESET_SUCCESS') {
            AppSnackBar.success(context, msg);
          } else {
            AppSnackBar.error(context, msg);
          }

          context.read<SettingsCubit>().clearActionMessage();
        },
        child: const SafeArea(child: _Body()),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
        child: ListView(
          padding: context.pagePadding,
          children: [
            AppSectionHeader(
              title: context.tr.appearance_section,
              icon: Icons.palette_outlined,
            ),
            SizedBox(height: context.tokens.s12),
            const _AppearanceSection(),

            SizedBox(height: context.tokens.s20),
            AppSectionHeader(
              title: context.tr.currency_section,
              icon: Icons.payments_outlined,
            ),
            SizedBox(height: context.tokens.s12),
            const _CurrencySection(),

            SizedBox(height: context.tokens.s20),
            AppSectionHeader(
              title: context.tr.data_section,
              icon: Icons.delete_outline,
            ),
            SizedBox(height: context.tokens.s12),
            const _DataSection(),

            SizedBox(height: context.tokens.s20),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _CurrencySection extends StatelessWidget {
  const _CurrencySection();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<SettingsCubit, SettingsState, String>(
        selector: (s) => s.currency,
        builder: (context, currency) {
          return SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'USD', label: Text(r'$')),
              ButtonSegment(value: 'ILS', label: Text('₪')),
              ButtonSegment(value: 'SAR', label: Text('SAR')),
            ],
            selected: {currency},
            onSelectionChanged: (set) {
              context.read<SettingsCubit>().setCurrency(set.first);
            },
          );
        },
      ),
    );
  }
}

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          child: BlocSelector<SettingsCubit, SettingsState, bool>(
            selector: (s) => s.isDark,
            builder: (context, isDark) {
              return SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  context.tr.darkMode,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                value: isDark,
                onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
              );
            },
          ),
        ),
        SizedBox(height: context.tokens.s12),
        AppCard(
          child: BlocSelector<SettingsCubit, SettingsState, String>(
            selector: (s) => s.locale,
            builder: (context, locale) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.language_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: context.tokens.s12),
                  SegmentedButton<String>(
                    segments: [
                      ButtonSegment(
                        value: 'ar',
                        label: Text(context.tr.arabic),
                      ),
                      ButtonSegment(
                        value: 'en',
                        label: Text(context.tr.english),
                      ),
                    ],
                    selected: {locale},
                    onSelectionChanged: (set) {
                      context.read<SettingsCubit>().setLocale(set.first);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DataSection extends StatelessWidget {
  const _DataSection();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<SettingsCubit, SettingsState, bool>(
        selector: (s) => s.isResetting,
        builder: (context, isResetting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.reset_data_title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: context.tokens.s8),
              Text(
                context.tr.reset_data_subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.colorWithOpacity(0.7),
                ),
              ),
              SizedBox(height: context.tokens.s12),
              SizedBox(
                width: double.infinity,
                height: context.isTablet ? 50 : 46,
                child: ElevatedButton(
                  onPressed: isResetting
                      ? null
                      : () async {
                          final ok = await AppDialog.confirm(
                            context,
                            title: context.tr.confirm_title,
                            message: context.tr.confirm_reset_body,
                            confirmText: context.tr.confirm,
                            cancelText: context.tr.cancel,
                            isDanger: true,
                            icon: Icons.warning_amber_rounded,
                          );

                          if (ok && context.mounted) {
                            await context.read<SettingsCubit>().resetAllData();
                          }
                        },
                  child: isResetting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(context.tr.delete_all_expenses),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocSelector<SettingsCubit, SettingsState, String?>(
      selector: (s) => s.appVersion,
      builder: (context, version) {
        return Center(
          child: Column(
            children: [
              Text(
                context.tr.app_name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurface.colorWithOpacity(0.6),
                ),
              ),
              SizedBox(height: context.tokens.s8),
              Text(
                context.tr.version(version ?? '-'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurface.colorWithOpacity(0.6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
