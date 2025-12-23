
import 'package:contact_saver/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<ThemeProvider>().themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SwitchListTile(
        title: const Text("Dark Mode & Light Mode"),
        value: isDark,
        onChanged: (value) {
          context.read<ThemeProvider>().toggleTheme(value);
        },
      ),
    );
  
  }
}
