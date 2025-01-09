class Migrations2 {
  static const String booksTable = "books_extended";
  static const String chaptersTable = "chapters";
  static const String sectionsTable = "sections";

  static const String createBooksTable = '''
    CREATE TABLE IF NOT EXISTS $booksTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      slug TEXT NOT NULL UNIQUE,
      author TEXT,
      cover_image TEXT,
      url TEXT,
      featured INTEGER DEFAULT 0,
      status INTEGER DEFAULT 1,
      published_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  ''';

  static const String createChaptersTable = '''
    CREATE TABLE IF NOT EXISTS $chaptersTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      book_id INTEGER NOT NULL,
      title TEXT NOT NULL,
      slug TEXT NOT NULL UNIQUE,
      published_at DATETIME,
      status INTEGER DEFAULT 0,
      order_column INTEGER DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      deleted_at DATETIME,
      FOREIGN KEY(book_id) REFERENCES $booksTable(id) ON DELETE CASCADE
    );
  ''';

  static const String createSectionsTable = '''
    CREATE TABLE IF NOT EXISTS $sectionsTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      chapter_id INTEGER NOT NULL,
      title TEXT NOT NULL,
      slug TEXT,
      old_slug TEXT,
      order_column INTEGER DEFAULT 0,
      published_at DATETIME,
      status INTEGER DEFAULT 0,
      content TEXT,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      deleted_at DATETIME,
      FOREIGN KEY(chapter_id) REFERENCES $chaptersTable(id) ON DELETE CASCADE
    );
  ''';
}
