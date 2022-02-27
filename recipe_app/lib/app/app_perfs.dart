import 'package:shared_preferences/shared_preferences.dart';

class SharedPerfs {
  static SharedPreferences? sharedPref;
  static Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
  }


}
