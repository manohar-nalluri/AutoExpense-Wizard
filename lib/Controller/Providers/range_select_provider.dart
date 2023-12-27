import 'package:flutter/material.dart';

class RangeSelectNotifier extends ChangeNotifier {
  int _selected = 0;
  final _selectedText = ['Today', 'This Week', 'This Month', 'Custom'];
  get selected => _selected;
  get selectedText => _selectedText;
  setSelected(int number) {
    _selected = number;
    notifyListeners();
  }
}
