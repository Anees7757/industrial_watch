import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPrefrences {
  static SharedPreferences? _preferences;

  void clearSharedPrefs() {
    _preferences!.clear();
  }

  static const _keyUserData = 'userData';
  static const _keyIp = 'ip';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(String userData) async =>
      await _preferences!.setString(_keyUserData, userData);

  static String getUser() => _preferences!.getString(_keyUserData) ?? '';

  static void removeUser() => _preferences!.remove(_keyUserData);

  static Future setIp(String ip) async =>
      await _preferences!.setString(_keyIp, ip);

  static String getIp() => _preferences!.getString(_keyIp) ?? '';
}
