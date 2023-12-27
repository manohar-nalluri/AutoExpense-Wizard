import 'package:expense_tracker/Controller/db_terms.dart';
import 'package:flutter/material.dart';
import '../../Services/dbhelper.dart';
import '../playing_with_dates.dart';

class DataNotifer extends ChangeNotifier {
  var _displayableItems = [];
  num _total = 0;
  final _dbhelper = Dbhelper.instance;
  DateTime _selectedDate = DateTime.now();
  final List _displayFormattedDates = [
    'Today, ${datemonth(formattedDate())}',
    ' ${datemonth(formattedDate(date: previousSunday()))} - ${datemonth(formattedDate())}',
    ' ${datemonth(formattedDate(date: monthStartDate()))} - ${datemonth(formattedDate())}',
    DateTime.now().toString()
  ];
  get displayableItems => _displayableItems;
  get displayableItemsLength => _displayableItems.length;
  get totalAmount => _total;
  get selectedDate => _selectedDate;
  get displayFormattedDates => _displayFormattedDates;
  setSelectedDate(date) {
    _selectedDate = date;
    _displayFormattedDates[3] = datemonth(formattedDate(date: _selectedDate));
    setCustomDate(_selectedDate);
  }

  setTotal() {
    _total = 0;
    for (var item in _displayableItems) {
      if (item[DBTerms.trackerColCategory] != 'Income' &&
          item[DBTerms.trackerColAmount] is num) {
        _total += item[DBTerms.trackerColAmount];
      }
    }
  }

  setTodayItems() async {
    _displayableItems = await _dbhelper.today();
    setTotal();
    notifyListeners();
  }

  setThisWeekItems() async {
    _displayableItems = await _dbhelper.thisWeek();
    setTotal();
    notifyListeners();
  }

  setThisMonthItems() async {
    _displayableItems = await _dbhelper.thisMonth();
    setTotal();
    notifyListeners();
  }

  setCustomDate(date) async {
    _displayableItems = await _dbhelper.customDate(date);
    setTotal();
    notifyListeners();
  }

  insertIntoDBAndRefresh(
      Map<String, dynamic> row, int selected, DateTime date) async {
    _dbhelper.insert(row);
    if (selected == 0) {
      setTodayItems();
    } else if (selected == 1) {
      setThisWeekItems();
    } else if (selected == 2) {
      setThisMonthItems();
    } else {}
  }
}
