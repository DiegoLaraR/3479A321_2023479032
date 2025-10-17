import 'package:flutter/material.dart';
import 'package:lab2/services/sharedPreferenceServices.dart';
import 'package:logger/logger.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService prefsService;
  Logger logger = Logger();

  int _size = 16;
  String _palette = "Default";

  int get getSize => _size;
  String get getPalette => _palette;

  ConfigurationData(this.prefsService) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _size = await prefsService.loadBoardSize();
    _palette = await prefsService.loadPalette();
    notifyListeners();
  }

  Future<void> setSize(int newSize) async {
    _size = newSize;
    await prefsService.saveBoardSize(newSize);
    notifyListeners();
  }

  Future<void> setPalette(String value) async {
    _palette = value;
    await prefsService.savePalette(value);
    notifyListeners();
  }
}
