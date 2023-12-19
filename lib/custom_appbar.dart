import 'package:animate_do/animate_do.dart';
import 'package:chatbot/translation.dart/change_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BounceInLeft(
              child: const Icon(
                Icons.menu,
                size: 40,
                color: Colors.black,
              ),
            ),
            BounceInDown(
              child: Text(
                "Ameya Bot".tr,
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            BounceInLeft(
              child: const Icon(
                Icons.exit_to_app,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BounceInDown(child: const LanguageSelector()),
      ],
    );
  }
}

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  LanguageSelectorState createState() => LanguageSelectorState();
}

class LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: [
        buildChoiceChip('English'),
        buildChoiceChip('हिंदी'),
        buildChoiceChip('ਪੰਜਾਬੀ'),
      ],
    );
  }

  Widget buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedLanguage == label,
      selectedColor: Colors.orange,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            selectedLanguage = label;
            if (label == "English") {
              ChangeTranslation().updateTranslation(const Locale('en_US'));
            } else if (label == "हिंदी") {
              ChangeTranslation().updateTranslation(const Locale('hi_IN'));
            } else {
              ChangeTranslation().updateTranslation(const Locale('pa_In'));
            }
          }
        });
      },
    );
  }
}
