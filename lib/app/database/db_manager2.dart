import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'migrations2.dart';

class DBManager2 {
  static const String _dbName = 'books_extended.db';
  static const int _dbVersion = 3;

  static final DBManager2 _instance = DBManager2._internal();
  Database? _database;

  DBManager2._internal();

  factory DBManager2() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, _dbName);

  return await openDatabase(
    path,
    version: _dbVersion,
    onCreate: (db, version) async {
      // Create tables for books, chapters, and sections
      await db.execute(Migrations2.createBooksTable);
      await db.execute(Migrations2.createChaptersTable);
      await db.execute(Migrations2.createSectionsTable);

      // Debug: Check if tables were created successfully
      List<Map<String, dynamic>> tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
      print("Tables created: $tables");
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Handle migrations for version 2
        await db.execute('ALTER TABLE ${Migrations2.booksTable} ADD COLUMN category TEXT');
      }
      if (oldVersion < 3) {
        // Handle migrations for version 3 (if there are additional schema changes)
        // You could add more changes for version 3 here if necessary
      }
    },
  );
}

  // Insert data into a specific table
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
  try {
    final db = await database;
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,  // Replaces if the entry already exists
    );
  } catch (e) {
    print("Insert Error: $e");
    return -1;
  }
}

  // Query data from a specific table
  Future<List<Map<String, dynamic>>> query(String tableName, {String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await database;
      return await db.query(tableName, where: where, whereArgs: whereArgs);
    } catch (e) {
      print("Query Error: $e");
      return [];
    }
  }

  // Update data in a specific table
  Future<int> update(String tableName, Map<String, dynamic> data, {String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await database;
      return await db.update(tableName, data, where: where, whereArgs: whereArgs);
    } catch (e) {
      print("Update Error: $e");
      return -1;
    }
  }

  // Delete data from a specific table
  Future<int> delete(String tableName, {String? where, List<dynamic>? whereArgs}) async {
    try {
      final db = await database;
      return await db.delete(tableName, where: where, whereArgs: whereArgs);
    } catch (e) {
      print("Delete Error: $e");
      return -1;
    }
  }

  // Query all data from a specific table
  Future<List<Map<String, dynamic>>> queryAll(String tableName, {String? where, List<dynamic>? whereArgs}) async {
  try {
    final db = await database;
    return await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  } catch (e) {
    print("Query Error: $e");
    return [];
  }
}
  // Specific queries for chapters and sections
  Future<List<Map<String, dynamic>>> queryChapters(int bookId) async {
    return await query(Migrations2.chaptersTable, where: 'book_id = ?', whereArgs: [bookId]);
  }

  Future<List<Map<String, dynamic>>> querySections(int chapterId) async {
    return await query(Migrations2.sectionsTable, where: 'chapter_id = ?', whereArgs: [chapterId]);
  }
  
  // Method to get all books, including their chapters and sections if needed (can be used for retrieving hierarchical data)
  Future<List<Map<String, dynamic>>> getBooksWithChaptersAndSections() async {
    List<Map<String, dynamic>> books = await queryAll(Migrations2.booksTable);
    for (var book in books) {
      List<Map<String, dynamic>> chapters = await queryChapters(book['id']);
      for (var chapter in chapters) {
        List<Map<String, dynamic>> sections = await querySections(chapter['id']);
        chapter['sections'] = sections; 
      }
      book['chapters'] = chapters; 
    }
    return books; 
  }
}
