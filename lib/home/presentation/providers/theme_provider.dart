import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/config/theme/app_theme.dart';
import 'package:mindsave/home/infrastructure/services/services.dart';

class ThemeNotifier extends StateNotifier<AppTheme> {

  final LocalStorageService _localStorageService;

  ThemeNotifier({
    required LocalStorageService localStorageService
  }) : 
    _localStorageService = localStorageService,
    super(AppTheme());

  Future<void> getDarkModeFromLocalStorage() async {
    final bool? isDarkMode = await _localStorageService.getValue<bool>("isDarkMode");
    state = state.copyWith(
      isDarkMode: isDarkMode ?? false
    );
  }

  void toggleDarkMode() async {
    await _localStorageService.setKeyValue<bool>("isDarkMode", !state.isDarkMode);
    state = state.copyWith(
      isDarkMode: !state.isDarkMode
    );
  }

}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) {
    LocalStorageService localStorageService = LocalStorageServiceImpl();
    return ThemeNotifier(localStorageService: localStorageService);
  }
);