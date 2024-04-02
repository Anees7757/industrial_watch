import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPrefrences {
  static SharedPreferences? _preferences;

  void clearSharedPrefs() {
    _preferences!.clear();
  }

  static const _keyUserData = 'userData';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(String userData) async =>
      await _preferences!.setString(_keyUserData, userData);

  static String getUser() => _preferences!.getString(_keyUserData) ?? '';

  static void removeUser() => _preferences!.remove(_keyUserData);
}
