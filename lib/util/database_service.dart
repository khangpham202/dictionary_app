import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "dict_bilingual.db");

    if (await databaseExists(path)) {
      return await openDatabase(path);
    } else {
      ByteData data =
          await rootBundle.load(join("assets", "dict_bilingual.db"));
      List<int> bytes = data.buffer.asUint8List();
      await writeToFile(path, Uint8List.fromList(bytes));

      return await openDatabase(path);
    }
  }

  Future<void> writeToFile(String path, Uint8List bytes) async {
    await File(path).writeAsBytes(bytes, flush: true);
    print('File copied to path: $path');
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database db = await database;
    return await db.query('av');
  }
}
