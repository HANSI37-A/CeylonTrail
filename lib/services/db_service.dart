import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/attraction.dart';

class DbService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'travel_guide.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            name TEXT,
            category TEXT,
            description TEXT,
            imageUrl TEXT,
            latitude REAL,
            longitude REAL,
            address TEXT
          )
        ''');
      },
    );
  }

  static Future<List<Attraction>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => Attraction.fromMap(maps[i]));
  }

  static Future<void> insertFavorite(Attraction attraction) async {
    final db = await database;
    await db.insert(
      'favorites',
      attraction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
