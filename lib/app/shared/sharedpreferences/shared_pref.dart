import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static read(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key) != null
        ? json.decode(prefs.getString(key))
        : null;
  }

  static save(String key, value) async {
    final prefs = await _prefs;
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await _prefs;
    prefs.remove(key);
  }
}
