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
    var path = join(databasesPath, "dict_hh.db");

    if (await databaseExists(path)) {
      return await openDatabase(path);
    } else {
      ByteData data = await rootBundle.load(join("assets/data", "dict_hh.db"));
      List<int> bytes = data.buffer.asUint8List();
      await writeToFile(path, Uint8List.fromList(bytes));

      return await openDatabase(path);
    }
  }

  Future<void> writeToFile(String path, Uint8List bytes) async {
    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<Word?> getEVWordData(String word) async {
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

  Future<Word?> getVEWordData(String word) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'va',
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
  Future<List<String>> getEnglishWordSuggestion() async {
    String data = await rootBundle.loadString('assets/data/en_sug_109k.txt');
    List<String> suggestions = LineSplitter.split(data).toList();
    return suggestions;
  }

  Future<List<String>> getVietnameseWordSuggestion() async {
    String data = await rootBundle.loadString('assets/data/vietanh.txt');

    List<String> lines = LineSplitter.split(data).toList();

    List<String> suggestions = lines
        .where((line) => line.startsWith('@'))
        .map((line) => line.substring(1).trim())
        .toList();

    return suggestions;
  }
}

Future<Map<String, List<Map<String, dynamic>>>> getEssentialWord() async {
  String jsonString =
      await rootBundle.loadString('assets/data/essential_words.json');

  Map<String, dynamic> jsonData = json.decode(jsonString);

  Map<String, List<Map<String, dynamic>>> vocabulary = {};

  for (String key in jsonData.keys) {
    List<dynamic> itemsJson = jsonData[key];

    List<Map<String, dynamic>> items = itemsJson.map((json) {
      return {
        'english': json['english'],
        'phonetic': json['phonetic'],
        'vietnamese': json['vietnamese'],
      };
    }).toList();

    vocabulary[key] = items;
  }

  return vocabulary;
}

Future<List<Map<String, dynamic>>> getTipLeanrning() async {
  String jsonString =
      await rootBundle.loadString('assets/data/tips_learning_English.json');

  Map<String, dynamic> jsonData = json.decode(jsonString);

  List<dynamic> itemsJson = jsonData['tips_to_learn_english'];

  List<Map<String, dynamic>> items = itemsJson.map((json) {
    return {
      'english': json['english'],
      'vietnamese': json['vietnamese'],
    };
  }).toList();

  return items;
}

Future<List<Map<String, dynamic>>> getConversationPhrase() async {
  String jsonString =
      await rootBundle.loadString('assets/data/conversation_phrases.json');

  List<dynamic> jsonData = json.decode(jsonString);

  List<Map<String, dynamic>> items = jsonData.map((json) {
    return {
      'english': json['english'],
      'phonetic': json['phonetic'],
      'vietnamese': json['vietnamese'],
    };
  }).toList();

  return items;
}

Future<List<Map<String, dynamic>>> getConversationQuestion() async {
  String jsonString =
      await rootBundle.loadString('assets/data/conversation_question.json');

  List<dynamic> jsonData = json.decode(jsonString);

  List<Map<String, dynamic>> items = jsonData.map((json) {
    return {
      'english': json['English'],
      'vietnamese': json['Vietnamese'],
    };
  }).toList();

  return items;
}
