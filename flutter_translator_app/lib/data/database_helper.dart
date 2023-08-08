import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:translator_app/models/TranslationHistory.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'translations.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE translation_history(
            id INTEGER PRIMARY KEY,
            original_text TEXT,
            translated_text TEXT,
            timestamp DATETIME
          )
        ''');
      },
    );
  }

  Future<void> insertTranslation(TranslationHistory history) async {
    await _database.insert(
      'translation_history',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TranslationHistory>> getTranslationHistory() async {
    final List<Map<String, dynamic>> maps = await _database.query('translation_history');

    return List.generate(maps.length, (i) {
      return TranslationHistory(
        id: maps[i]['id'],
        originalText: maps[i]['original_text'],
        translatedText: maps[i]['translated_text'],
        timestamp: DateTime.parse(maps[i]['timestamp']),
      );
    });
  }
}
