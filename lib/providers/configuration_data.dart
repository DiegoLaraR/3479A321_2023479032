import 'package:flutter/material.dart';
import 'package:lab2/services/sharedPreferenceServices.dart';
import 'package:logger/logger.dart';
import 'package:lab2/models/pixel_art.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService prefsService;
  Logger logger = Logger();

  int _size = 16;
  String _palette = "Default";
  double _backgroundOpacity = 0.5;

  int get getSize => _size;
  String get getPalette => _palette;
  double get getOpacity => _backgroundOpacity;

  ConfigurationData(this.prefsService) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _size = await prefsService.loadBoardSize();
    _palette = await prefsService.loadPalette();
    _backgroundOpacity = await prefsService.loadBackgroundOpacity();
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

  Future<void> setBackgroundOpacity(double value) async {
    _backgroundOpacity = value;
    await prefsService.saveBackgroundOpacity(value);
    notifyListeners();
  }
  // NUEVOS MÉTODOS AGREGADOS POR IA

  Future<void> savePixelArtProgress(
    List<Color> colors,
    int size,
    String title,
  ) async {
    await prefsService.savePixelArtInProgress(colors, size, title);
  }

  Future<PixelArt?> loadPixelArtProgress() async {
    return await prefsService.loadPixelArtInProgress();
  }
}
