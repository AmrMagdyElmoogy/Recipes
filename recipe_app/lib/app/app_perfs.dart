import 'package:shared_preferences/shared_preferences.dart';

class SharedPerfs {
  static SharedPreferences? sharedPref;
  static Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static void initalizeIndexesOfFavorities(String key, List<String> list) {
    sharedPref!.setStringList(key, list);
  }

  static List<String>? getIndexesOfFavorities(String key) {
    return sharedPref!.getStringList(key) ?? List.filled(10, 'false');
  }
}
