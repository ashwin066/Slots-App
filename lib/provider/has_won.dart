import 'package:flutter/material.dart';

class HasWon with ChangeNotifier {
  List<String> _hasWon = [];

   List<String> get winnersNameList => _hasWon;

  void addItem(String item) {
    _hasWon.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    _hasWon.remove(item);
    notifyListeners();
  }

  void removeAt(int item) {
    _hasWon.removeAt(item);
    notifyListeners();
  }

  void removeWhere(item) {
    _hasWon.removeWhere(item);
    notifyListeners();
  }

  void clear() {
    _hasWon.clear();
    notifyListeners();
  }
}
