import 'package:flutter/material.dart';

class ConfigurationData extends ChangeNotifier {
  int _size = 16;
  int get getSize => _size;

  notifyListeners();
}
