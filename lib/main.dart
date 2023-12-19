import 'package:chatbot/home_screen.dart';
import 'package:chatbot/pallete.dart';
import 'package:chatbot/translation.dart/language_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ameya Bot',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.whiteColor,
        ),
      ),
      translations: LanguageStrings(),
      locale: const Locale('en_US'),
      fallbackLocale: const Locale('en_US'),
      // home: const ChatScreen(),
      home: const HomePage(),
      //    home: TranslatorDemo(),
    );
  }
}
