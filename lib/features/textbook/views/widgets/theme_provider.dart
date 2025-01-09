import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false); // Default is light mode

  void toggleTheme(bool isDarkMode) {
    state = isDarkMode;
  }
}
