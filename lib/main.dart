import 'package:flutter/material.dart';
import 'package:goals/pages/home.dart';
import 'package:goals/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GoalsApp(
    theme: ThemeOption.light,
  ));
}

class GoalsApp extends StatelessWidget {
  GoalsApp({Key? key, required ThemeOption theme})
      : _themeNotifier = ValueNotifier(theme),
        super(key: key);

  final ValueNotifier<ThemeOption> _themeNotifier;

  @override
  Widget build(BuildContext context) {
    restoreTheme();

    return ValueListenableBuilder(
      valueListenable: _themeNotifier,
      child: HomePage(updateTheme: onThemeUpdate),
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'Goals',
          theme: buildLightTheme(),
          darkTheme: buildDarkTheme(),
          themeMode:
              theme == ThemeOption.dark ? ThemeMode.dark : ThemeMode.light,
          home: child,
        );
      },
    );
  }

  Future<void> onThemeUpdate(ThemeOption theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme.name);

    _themeNotifier.value = theme;
  }

  Future<void> restoreTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final theme = prefs.getString("theme");

    if (theme == ThemeOption.dark.name) {
      _themeNotifier.value = ThemeOption.dark;
    }
  }
}
