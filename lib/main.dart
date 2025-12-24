import 'package:contact_saver/appColor/app_theme.dart';

import 'package:contact_saver/provider/contact_form_provider.dart';
import 'package:contact_saver/provider/contact_provider.dart';
import 'package:contact_saver/provider/theme_provider.dart';

import 'package:contact_saver/sceens/main_page_screen.dart';

import 'package:flutter/material.dart';
import 'package:contact_saver/provider/image_provider.dart';

import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final contactProvider = ContactProvider();
  await contactProvider.loadContacts();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider()..loadContacts(),
        ),
        ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (context) => ContactFormProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),

        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      home: MainPage(),
    );
  }
}
