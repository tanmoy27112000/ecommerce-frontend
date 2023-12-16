import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._privateConstructor();
  static late SharedPreferences _preference;

  static final Prefs _instance = Prefs._privateConstructor();

  static Prefs get instance => _instance;

  Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  //sets
  static Future<bool> setBool(String key, bool value) async => _preference.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async => _preference.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async => _preference.setInt(key, value);

  static Future<bool> setString(String key, String value) async => _preference.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _preference.setStringList(key, value);

  //gets
  static bool getBool(String key) => _preference.getBool(key) ?? false;

  static double getDouble(String key) => _preference.getDouble(key) ?? 0.0;

  static int getInt(String key) => _preference.getInt(key) ?? 0;

  static String getString(String key) => _preference.getString(key) ?? '';

  dynamic get(String key) => _preference.get(key) ?? '';

  static List<String> getStringList(String key) => _preference.getStringList(key) ?? [];

  //deletes..
  static Future<bool> remove(String key) async => _preference.remove(key);

  Future<void> clear() async => _preference.clear();
}
