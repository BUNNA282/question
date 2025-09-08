// lib/main.dart
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_app_game/l10n/app_localizations.dart';
import 'package:flutter_app_game/screens/home_screen.dart';
import 'package:flutter_app_game/services/audio_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// CORRECTED IMPORT: Use your project's package name and the 'generated' folder
import 'package:flutter_app_game/generated/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioService.init();
  // Load saved locale preference
  final prefs = await SharedPreferences.getInstance();
  final String? savedLocaleCode = prefs.getString('languageCode');
  Locale? initialLocale;
  if (savedLocaleCode != null) {
    initialLocale = Locale(savedLocaleCode);
  }

  runApp(MyApp(initialLocale: initialLocale)); // Pass initial locale to MyApp
}

class MyApp extends StatefulWidget {
  final Locale? initialLocale;
  const MyApp({super.key, this.initialLocale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale; // State variable for locale

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale; // Set initial locale from passed value
  }

  // Method to set new locale
  void setLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      setState(() {
        _locale = newLocale;
      });
      // Save locale to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('languageCode', newLocale.languageCode);
    }
  }

  @override
  void dispose() {
    AudioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khmer Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Add localization delegates
      localizationsDelegates: const [
        AppLocalizations.delegate, // Generated delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Add supported locales
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('km', ''), // Khmer
      ],
      // Set the locale based on state
      locale: _locale,
      home: HomeScreen(
        setLocale: setLocale,
      ), // Pass setLocale function to HomeScreen
      debugShowCheckedModeBanner: false,
    );
  }
}
