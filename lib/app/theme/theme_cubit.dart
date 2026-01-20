import 'package:flutter_bloc/flutter_bloc.dart';
import '../settings/settings_local_ds.dart';
import 'app_theme.dart';
import 'theme_state.dart';


class ThemeCubit extends Cubit<ThemeState> {
  final SettingsLocalDataSource _ds;

  ThemeCubit(this._ds)
      : super(ThemeState(themeData: AppTheme.light(), isDark: false));

  Future<void> load() async {
    final saved = await _ds.getThemeMode(); // 'light' | 'dark'
    final isDark = saved == 'dark';

    emit(
      ThemeState(
        themeData: isDark ? AppTheme.dark() : AppTheme.light(),
        isDark: isDark,
      ),
    );
  }

  Future<void> toggle() async {
    final nextIsDark = !state.isDark;

    emit(
      ThemeState(
        themeData: nextIsDark ? AppTheme.dark() : AppTheme.light(),
        isDark: nextIsDark,
      ),
    );

    await _ds.setThemeMode(nextIsDark ? 'dark' : 'light');
  }
}
