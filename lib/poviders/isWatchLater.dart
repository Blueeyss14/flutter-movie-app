import 'package:flutter/material.dart';

class WatchLater with ChangeNotifier {
  List<bool> _isWatchLater = [];

  List<bool> get isWatchLater => _isWatchLater;

  void initializeList(int length) {
    _isWatchLater = List<bool>.filled(length, false);
    notifyListeners();
  }

  void toggleWatchLater(int index) {
    for (int i = 0; i < _isWatchLater.length; i++) {
      _isWatchLater[index] = !_isWatchLater[index];
      notifyListeners();
    }
    if (index >= 0 && index < _isWatchLater.length) {
      _isWatchLater[index] = !_isWatchLater[index];
      notifyListeners();
    }
  }
}
