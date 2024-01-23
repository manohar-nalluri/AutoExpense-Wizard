import 'dart:io';
import 'package:expense_tracker/Controller/playing_with_dates.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  static const _dbName = 'Tracker.db';
  static const _dbVersion = 1;
  static const trackerTable = 'Tracking';
  static const trackerColId = 'TrackerId';
  static const trackerColDate = 'TrackerDate';
  static const trackerColDescription = 'TrackerDescription';
  static const trackerColAmount = 'TrackerAmount';
  static const trackerColCategory = 'TrackerCategory';
  static const trackerColType = 'TrackerType';
  static const trackerColAI = 'TrackerAI';

  Dbhelper._privateConstructor();
  static final Dbhelper instance = Dbhelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initdb();
    return _database!;
  }

  _initdb() async {
    Directory documnet = await getApplicationDocumentsDirectory();
    String path = join(documnet.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $trackerTable(
  $trackerColId INTEGER PRIMARY KEY,
  $trackerColDescription TEXT NOT NULL,
  $trackerColAmount INTEGER NOT NULL,
  $trackerColDate DATE NOT NULL,
  $trackerColCategory TEXT NOT NULL,
  $trackerColType TEXT NOT NULL,
  $trackerColAI BOOLEAN DEFAULT 0
)
''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(trackerTable, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;
    return await db.query(trackerTable);
  }

  Future<List<Map<String, dynamic>>> today() async {
    Database db = await instance.database;
    var today = formattedDate();
    var res = await db.query(
      trackerTable,
      where: "$trackerColDate = ?",
      whereArgs: [today],
    );

    return res;
  }

  Future<List<Map<String, dynamic>>> thisWeek() async {
    Database db = await instance.database;
    var todaydate = formattedDate();
    var previousSundayDate = formattedDate(date: previousSunday());
    List<Map<String, dynamic>> result = await db.query(
      trackerTable,
      where: '$trackerColDate BETWEEN ? AND ?',
      whereArgs: [previousSundayDate, todaydate],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> thisMonth() async {
    Database db = await instance.database;
    var todaydate = formattedDate();
    var monthStartingDate = formattedDate(date: monthStartDate());
    List<Map<String, dynamic>> result = await db.query(
      trackerTable,
      where: '$trackerColDate BETWEEN ? AND ?',
      whereArgs: [monthStartingDate, todaydate],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> customDate(DateTime custom) async {
    Database db = await instance.database;
    var customDate = DateFormat('yyyy-MM-dd').format(custom);
    var res = await db.query(
      trackerTable,
      where: "$trackerColDate = ?",
      whereArgs: [customDate],
    );
    return res;
  }

  Future<List<Map<String, dynamic>>> month(int month, int year) async {
    Database db = await instance.database;

    var monthStartingDate =
        formattedDate(date: givenMonthStartDate(month, year));
    var monthEndDate = formattedDate(date: givenMonthEndDate(month, year));
    List<Map<String, dynamic>> result = await db.query(
      trackerTable,
      where: '$trackerColDate BETWEEN ? AND ?',
      whereArgs: [monthStartingDate, monthEndDate],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> wizardAI() async {
    Database db = await instance.database;
    var today = formattedDate();
    var res = await db.query(
      trackerTable,
      where: "$trackerColDate = ? AND $trackerColAI = ?",
      whereArgs: [today,1],
    );
    return res;
  }
}
