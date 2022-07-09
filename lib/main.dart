import 'package:flutter/material.dart';
import 'package:goals/pages/home.dart';
import 'package:goals/theme.dart';

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

  void onThemeUpdate(ThemeOption theme) {
    _themeNotifier.value = theme;
  }
}
