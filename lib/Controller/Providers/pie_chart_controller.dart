import 'package:expense_tracker/Controller/contorller_global_export.dart';
import 'package:expense_tracker/Controller/db_terms.dart';
import 'package:expense_tracker/Services/dbhelper.dart';
import 'package:flutter/material.dart';

import '../../Services/user_preference.dart';

class PieChartController extends ChangeNotifier {
  final _dbhelper = Dbhelper.instance;
  var _hasValues = false;
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  final List<Color> _color = [
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.blueGrey,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.limeAccent,
    Colors.purple,
    Colors.pink
  ];
  final List<Color> _progressColor = [Colors.green,Colors.yellow,Colors.red];
  final _catogeryExpense = UserPreference.getUserBudget() ??
      {
        "Shopping": {
          "value": 0,
          "color": 0,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Rent": {
          "value": 0,
          "color": 1,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Food": {
          "value": 0,
          "color": 2,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Entertainment": {
          "value": 0,
          "color": 3,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Other Expense": {
          "value": 0,
          "color": 4,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Utilities": {
          "value": 0,
          "color": 5,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Groceries": {
          "value": 0,
          "color": 6,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Fuel": {
          "value": 0,
          "color": 7,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Travel": {
          "value": 0,
          "color": 8,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
        "Health": {
          "value": 0,
          "color": 9,
          "budget": -1,
          "completed": 0,
          "progress": 0.05,
          "progresscolor": 0
        },
      };
  get budget => _catogeryExpense;
  get color => _color;
  get progressColor => _progressColor;
  get catogeryExpense => _catogeryExpense;
  get hasValues => _hasValues;
  get selectedMonth => _selectedMonth;
  get selectedYear => _selectedYear;
  setBudget(String key, int amount) {
    _catogeryExpense[key]!['budget'] = amount;

    progressCalculator();
    notifyListeners();
  }

  setSelectedMonth(int month) async {
    _selectedMonth = month;
    setMonthValues();
  }

  setSelectedYear(int year) async {
    _selectedYear = year;
    setMonthValues();
  }

  setMonthValues() async {
    List<Map<String, dynamic>> items =
        await _dbhelper.month(_selectedMonth, _selectedYear);
    _catogeryExpense.forEach(
      (key, value) => value['value'] = 0,
    );
    if (_selectedMonth == DateTime.now().month &&
        _selectedYear == DateTime.now().year) {
      _catogeryExpense.forEach(
        (key, value) => value['completed'] = 0,
      );
    }
    for (var item in items) {
      if (item[DBTerms.trackerColCategory] != 'Income') {
        _catogeryExpense[item[DBTerms.trackerColCategory]]!['value'] +=
            item[DBTerms.trackerColAmount];
        if (_selectedMonth == DateTime.now().month &&
            _selectedYear == DateTime.now().year) {
          _catogeryExpense[item[DBTerms.trackerColCategory]]!['completed'] +=
              item[DBTerms.trackerColAmount];
        }
      }
    }
    _catogeryExpense.forEach(
      (key, value) {
        if (value['value'] != 0) {
          _hasValues = true;
        } else {
          _hasValues = false;
        }
      },
    );
    if (_selectedMonth == DateTime.now().month &&
        _selectedYear == DateTime.now().year) {
      progressCalculator();
    }

    notifyListeners();
  }

  updateComplete() async {
    List<Map<String, dynamic>> items =
        await _dbhelper.month(_selectedMonth, _selectedYear);
    _catogeryExpense.forEach((key, value) => value['completed'] = 0);
    for (Map<String, dynamic> item in items) {
      if (item[DBTerms.trackerColCategory] != 'Income') {
        _catogeryExpense[item[DBTerms.trackerColCategory]]!['completed'] +=
            item[DBTerms.trackerColAmount];
      }
    }
    progressCalculator();
  }

  progressCalculator() async {
    for (var item in _catogeryExpense.keys) {
      if (_catogeryExpense[item]!['budget'] == -1 ||
          _catogeryExpense[item]!['budget'] == 0) {
        _catogeryExpense[item]!['progress'] = 0.05;
      } else if (_catogeryExpense[item]!['completed'] == 0) {
        _catogeryExpense[item]!['progress'] = 0.01;
      } else {
        _catogeryExpense[item]!['progress'] =
            _catogeryExpense[item]!['completed']! /
                _catogeryExpense[item]!['budget']!;
        if (_catogeryExpense[item]!['progress'] > 0.99) {
          _catogeryExpense[item]!['progress'] = 0.99;
        }
      }
      if (_catogeryExpense[item]!['progress'] <= 0.50) {
        _catogeryExpense[item]!["progresscolor"] = 0;
      } else if (_catogeryExpense[item]!['progress'] <= 0.70) {
        _catogeryExpense[item]!["progresscolor"] = 1;
      } else {
        _catogeryExpense[item]!["progresscolor"] = 2;
      }
    }
    await UserPreference.setUserBudget(_catogeryExpense);
  }
}
