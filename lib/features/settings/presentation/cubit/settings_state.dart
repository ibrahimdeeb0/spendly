import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isLoading;
  final bool isDark;
  final String locale; // 'ar' | 'en'
  final String currency; // 'USD' | 'ILS' | 'SAR'

  const SettingsState({
    required this.isLoading,
    required this.isDark,
    required this.locale,
    required this.currency,
  });

  factory SettingsState.initial() => const SettingsState(
    isLoading: true,
    isDark: false,
    locale: 'ar',
    currency: 'USD',
  );

  SettingsState copyWith({
    bool? isLoading,
    bool? isDark,
    String? locale,
    String? currency,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      isDark: isDark ?? this.isDark,
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [isLoading, isDark, locale, currency];
}
