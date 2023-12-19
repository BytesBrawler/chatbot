import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTranslation {
  void updateTranslation(Locale valueLocale) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("language", valueLocale.toString());
    Get.updateLocale(valueLocale);
    print("Transalation changed");
  }
}
