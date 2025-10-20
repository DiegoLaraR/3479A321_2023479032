// SharedPreferencesService.dart
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _keyBoardSize = 'boardSize';
  static const String _keyPalette = 'palette';

  Future<int> loadBoardSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyBoardSize) ?? 16;
  }

  Future<String> loadPalette() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPalette) ?? "Default";
  }

  Future<void> saveBoardSize(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyBoardSize, value);
  }

  Future<void> savePalette(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPalette, value);
  }
}
