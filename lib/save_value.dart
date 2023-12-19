import 'package:shared_preferences/shared_preferences.dart';

class SaveValues {
  void saveStringValues(String key, String text) async {
    SharedPreferences information = await SharedPreferences.getInstance();
    await information.setString(key, text);
    print(key);
  }

  void saveBoolValues(String key, bool value) async {
    SharedPreferences information = await SharedPreferences.getInstance();
    await information.setBool(key, value);
    print(key);
  }

  Future<String> getStringValues(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    key = sharedPreferences.getString(key)!;
    print(key);
    return key;
  }

  Future<bool?> getBoolValues(String? key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? value = sharedPreferences.getBool(key!);
    print(value);
    return value;
  }
}
