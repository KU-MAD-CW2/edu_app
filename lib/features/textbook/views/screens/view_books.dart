import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/database/db_manager2.dart';
import '../../../../app/database/migrations2.dart';
import 'package:edu_app/features/textbook/views/widgets/theme_provider.dart';

class ViewBooksScreen extends ConsumerStatefulWidget {
  const ViewBooksScreen({super.key});

  @override
  ConsumerState<ViewBooksScreen> createState() => _ViewBooksScreenState();
}

class _ViewBooksScreenState extends ConsumerState<ViewBooksScreen> {
  final DBManager2 _dbManager2 = DBManager2();
  List<Map<String, dynamic>> _books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final books = await _dbManager2.queryAll(Migrations2.booksTable);
    setState(() {
      _books = books;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchChapters(int bookId) async {
    return await _dbManager2.queryAll(
      Migrations2.chaptersTable,
      where: 'book_id = ?',
      whereArgs: [bookId],
    );
  }

  Future<List<Map<String, dynamic>>> _fetchSections(int chapterId) async {
    return await _dbManager2.queryAll(
      Migrations2.sectionsTable,
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
  }

  void _showBookDetailsPopup(Map<String, dynamic> book) async {
    final chapters = await _fetchChapters(book['id']);
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book['title'],
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (book['author'] != null)
                Text(
                  'Author: ${book['author']}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              const SizedBox(height: 8),
              if (book['category'] != null)  // Add this line to show the category
                Text(
                  'Category: ${book['category']}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              const SizedBox(height: 16),
              const Text(
                'Chapters:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = chapters[index];
                    return FutureBuilder<List<Map<String, dynamic>>>( 
                      future: _fetchSections(chapter['id']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final sections = snapshot.data ?? [];
                        return ExpansionTile(
                          title: Text(
                            chapter['title'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          children: sections.map((section) {
                            return ListTile(
                              title: Text(
                                section['title'],
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Text(
                                section['content'] ?? 'No content available',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to delete a book
  Future<void> _deleteBook(int bookId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book'),
        content: const Text('Are you sure you want to delete this book?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _dbManager2.delete(
                Migrations2.booksTable,
                where: 'id = ?',
                whereArgs: [bookId],
              );
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (result == true) {
      _fetchBooks(); // Refresh the list after deletion
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);

    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    Color subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Books',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigoAccent),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: Container(
        color: backgroundColor,
        child: _books.isEmpty
            ? Center(
                child: Text(
                  'No books available.',
                  style: TextStyle(color: textColor),
                ),
              )
            : ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    child: ListTile(
                      leading: book['cover_image'] != null && book['cover_image'].isNotEmpty
                          ? Image.file(
                              File(book['cover_image']),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.book, size: 50),
                      title: Text(
                        book['title'],
                        style: TextStyle(color: textColor),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (book['author'] != null)
                            Text(
                              'Author: ${book['author']}',
                              style: TextStyle(color: subtitleColor),
                            ),
                          if (book['category'] != null)  // Add category here as well
                            Text(
                              'Category: ${book['category']}',
                              style: TextStyle(color: subtitleColor),
                            ),
                          if (book['url'] != null)
                            Text(
                              'Status: ${book['status'] == 1 ? 'Active' : 'Inactive'}',
                              style: TextStyle(color: subtitleColor),
                            ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteBook(book['id']),
                      ),
                      onTap: () => _showBookDetailsPopup(book),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

