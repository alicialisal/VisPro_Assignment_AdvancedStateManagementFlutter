import 'package:flutter/material.dart';

class GlobalState with ChangeNotifier {
  List<int> _counters = [];
  List<Color> _colors = [];

  List<int> get counters => _counters;
  List<Color> get colors => _colors;

  void addCounter() {
    _counters.add(0);
    _colors.add(Colors.primaries[_counters.length % Colors.primaries.length]);
    notifyListeners();
  }

  void removeCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters.removeAt(index);
      _colors.removeAt(index);
      notifyListeners();
    }
  }

  void changeColor(int index, Color color) {
    if (index >= 0 && index < _colors.length) {
      _colors[index] = color;
      notifyListeners();
    }
  }

  void incrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters[index]++;
      notifyListeners();
    }
  }

  void decrementCounter(int index) {
    if (index >= 0 && index < _counters.length && _counters[index] > 0) {
      _counters[index]--;
      notifyListeners();
    }
  }
}
