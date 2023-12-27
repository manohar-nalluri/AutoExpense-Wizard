import 'package:intl/intl.dart';

previousSunday() {
  var today = DateTime.now();
  int dayOfWeek = today.weekday;
  var previousSundayDays = dayOfWeek - DateTime.sunday;
  if (previousSundayDays <= 0) {
    previousSundayDays += 7;
  }
  DateTime previousSunday = today.subtract(Duration(days: previousSundayDays));
  return previousSunday;
}

monthStartDate() {
  var today = DateTime.now();
  DateTime firstDayOfMonth = DateTime(today.year, today.month, 1);
  // var monthStartingDate = DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
  return firstDayOfMonth;
}

givenMonthStartDate(int month, int year) {
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  return firstDayOfMonth;
}

givenMonthEndDate(int month, int year) {
  DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);

  DateTime lastDayOfMonth =
      firstDayOfNextMonth.subtract(const Duration(days: 1));

  return lastDayOfMonth;
}

formattedDate({DateTime? date}) {
  date ??= DateTime.now();
  var todaydate = DateFormat('yyyy-MM-dd').format(date);
  return todaydate;
}

datemonth(date) {
  var splitted = date.split('-');
  var val = splitted[2];
  val = int.parse(val);
  if (val == 1) {
    val = '1st';
  } else if (val == 2) {
    val = '2nd';
  } else if (val == 3) {
    val = '3rd';
  } else {
    val = '${val.toString()}th';
  }
  date = DateTime.parse(date);
  String month = DateFormat.MMM().format(date);
  return '$val $month';
}
