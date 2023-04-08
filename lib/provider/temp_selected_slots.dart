import 'package:flutter/material.dart';

class TempReservedSlots with ChangeNotifier {
  List<int> _tempReservedSlots = [];

  int get count => _tempReservedSlots.length;
  List<int> get selectedSlots => _tempReservedSlots;

  void addItem(int item) {
    _tempReservedSlots.add(item);
    notifyListeners();
  }

  void removeItem(int item) {
    _tempReservedSlots.remove(item);
    notifyListeners();
  }

  void removeAt(int item) {
    _tempReservedSlots.removeAt(item);
    notifyListeners();
  }

  void removeWhere(item) {
    _tempReservedSlots.removeWhere(item);
    notifyListeners();
  }

  void clear() {
    _tempReservedSlots.clear();
    notifyListeners();
  }
}
