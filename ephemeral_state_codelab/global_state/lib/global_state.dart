library global_state;

import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  final List<int> counters = [];
  final List<Color> colors = [];

  void addCounter() {
    counters.add(0);
    colors.add(Colors.primaries[counters.length % Colors.primaries.length]);
    notifyListeners();
  }

  void removeCounter(int index) {
    counters.removeAt(index);
    colors.removeAt(index);
    notifyListeners();
  }

  void incrementCounter(int index) {
    counters[index]++;
    notifyListeners();
  }

  void decrementCounter(int index) {
    if (counters[index] > 0) counters[index]--;
    notifyListeners();
  }

  void changeColor(int index, Color color) {
    colors[index] = color;
    notifyListeners();
  }
}
