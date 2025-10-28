// SharedPreferencesService.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab2/models/pixel_art.dart';

class SharedPreferencesService {
  static const String _keyBoardSize = 'boardSize';
  static const String _keyPalette = 'palette';
  static const String _keyBackgroundOpacity = 'backgroundOpacity';
  // NUEVOS KEYS AGREGADOS POR IA
  static const String _keyPixelArtInProgress = 'pixelArtInProgress';

  Future<int> loadBoardSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyBoardSize) ?? 16;
  }

  Future<String> loadPalette() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPalette) ?? "Default";
  }

  Future<double> loadBackgroundOpacity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyBackgroundOpacity) ?? 0.5;
  }

  Future<void> saveBoardSize(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyBoardSize, value);
  }

  Future<void> savePalette(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPalette, value);
  }

  Future<void> saveBackgroundOpacity(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyBackgroundOpacity, value);
  }

  // NUEVOS MÉTODOS AGREGADOS POR IA

  Future<void> savePixelArtInProgress(
    List<Color> colors,
    int size,
    String title,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert colors to strings for gridData
    final List<String> colorStrings = colors
        .map((color) => color.value.toString())
        .toList();
    final String gridData = jsonEncode(colorStrings);

    // Create PixelArt object
    final pixelArt = PixelArt(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: 'local_user',
      title: title,
      description: 'Work in progress',
      size: {'width': size, 'height': size},
      palette: colorStrings,
      gridData: gridData,
      createdAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
    );

    // Save as JSON string
    await prefs.setString(
      _keyPixelArtInProgress,
      jsonEncode({
        'id': pixelArt.id,
        'authorId': pixelArt.authorId,
        'title': pixelArt.title,
        'description': pixelArt.description,
        'size': pixelArt.size,
        'palette': pixelArt.palette,
        'gridData': pixelArt.gridData,
        'createdAt': pixelArt.createdAt.toIso8601String(),
        'lastModifiedAt': pixelArt.lastModifiedAt.toIso8601String(),
      }),
    );
  }

  Future<PixelArt?> loadPixelArtInProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_keyPixelArtInProgress);

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return PixelArt(
      id: jsonMap['id'],
      authorId: jsonMap['authorId'],
      title: jsonMap['title'],
      description: jsonMap['description'],
      size: jsonMap['size'],
      palette: List<String>.from(jsonMap['palette']),
      gridData: jsonMap['gridData'],
      createdAt: DateTime.parse(jsonMap['createdAt']),
      lastModifiedAt: DateTime.parse(jsonMap['lastModifiedAt']),
    );
  }
}
