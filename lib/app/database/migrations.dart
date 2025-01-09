class Tables {
  static String tableTitle = "books";

  static String noteTables = '''
    CREATE TABLE IF NOT EXISTS $tableTitle(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      author TEXT,
      cover_image TEXT,
      url TEXT,  
      publishedAt DATETIME DEFAULT CURRENT_TIMESTAMP
    );
   ''';
}
