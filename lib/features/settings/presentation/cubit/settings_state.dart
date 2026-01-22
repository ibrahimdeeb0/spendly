import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isLoading;
  final bool isDark;
  final String locale;
  final String currency;

  final String? appVersion; // e.g. "1.0.0 (10)"
  final bool isResetting; // UI loading on reset
  final String? actionMessage; // success/error message (one-shot)

  const SettingsState({
    required this.isLoading,
    required this.isDark,
    required this.locale,
    required this.currency,
    required this.appVersion,
    required this.isResetting,
    required this.actionMessage,
  });

  factory SettingsState.initial() => const SettingsState(
    isLoading: true,
    isDark: false,
    locale: 'ar',
    currency: 'USD',
    appVersion: null,
    isResetting: false,
    actionMessage: null,
  );

  SettingsState copyWith({
    bool? isLoading,
    bool? isDark,
    String? locale,
    String? currency,
    String? appVersion,
    bool? isResetting,
    String? actionMessage,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      isDark: isDark ?? this.isDark,
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      appVersion: appVersion ?? this.appVersion,
      isResetting: isResetting ?? this.isResetting,
      actionMessage: actionMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isDark,
    locale,
    currency,
    appVersion,
    isResetting,
    actionMessage,
  ];
}
