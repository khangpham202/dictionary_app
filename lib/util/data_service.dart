import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:training/core/common/model/word.dart';

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
          await rootBundle.load(join("assets/data", "dict_bilingual.db"));
      List<int> bytes = data.buffer.asUint8List();
      await writeToFile(path, Uint8List.fromList(bytes));

      return await openDatabase(path);
    }
  }

  Future<void> writeToFile(String path, Uint8List bytes) async {
    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<Word?> getWordData(String word) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'av',
      where: 'word = ?',
      whereArgs: [word],
    );

    if (result.isNotEmpty) {
      return Word(
        word: result[0]['word'],
        pronounce: result[0]['pronounce'],
        description: result[0]['description'],
      );
    } else {
      return null;
    }
  }
}

class WordSuggestion {
  Future<List<String>> getEnglishWord() async {
    String data = await rootBundle.loadString('assets/data/en_vi_109k.txt');
    List<String> suggestions = LineSplitter.split(data).toList();
    return suggestions;
  }
}
