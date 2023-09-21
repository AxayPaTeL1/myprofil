/*
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
   DatabaseHelper _instance;
   Database _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'my_profile.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE profile (
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            imagePath TEXT,
            skills TEXT,
            experience TEXT
          )
        ''');
      },
    );
  }
}
*/

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelpper {
  static const _databasename = "myProfile.db";
  static const _databaseversion = 1;

  static const table = "my_table";


  static Database? _database;

  DatabaseHelpper._privateConstuctor();
  static DatabaseHelpper instance = DatabaseHelpper._privateConstuctor();

  factory DatabaseHelpper() {
    if (instance == null) {
      instance = DatabaseHelpper.instance;
    }
    return instance;
  }
  Future<Database?> get databse async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
 CREATE TABLE profile (
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            imagePath TEXT,
            skills TEXT,
            experience TEXT
          )
        ''');
  }


  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.databse;
    return await db!.insert(table, row);
  }

  // Future<List<Map<String, dynamic>>> queryall() async {
  //   Database? db = await instance.databse;
  //   return await db!.query(table);
  // }

  Future<List> getAllRecords(String dbTable) async {
    var dbClient = await instance.databse;
    List<Map<String, dynamic>> result = await dbClient!.rawQuery("SELECT * FROM $dbTable");
    print("get all records $result");
    return result;
  }

  /*Future<List<DatabaseHelpper>> getdata() async {
    final db = await databse;
    final List<Map<String, dynamic>> maps = await db!.query('getdata');

    return List.generate(maps.length, (i) {
      return DatabaseHelpper(
        id: maps[i]["id"],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }*/

  Future<int> delete(int id) async {
    var dbClint = await _database;
    return await dbClint!.delete('$table', where: "id = ?", whereArgs: [id]);
  }

// Future<int>update(int id) async{
//   Database? db = await instance.databse;
//   var res = await db.update(table, {})
// }


}
