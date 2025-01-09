import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
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

  Future<void> _deleteBook(int id) async {
    await _dbManager2.delete(
      Migrations2.booksTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchBooks();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Book deleted successfully!')),
    );
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
                          if (book['url'] != null)
                            Text(
                              'URL: ${book['url']}',
                              style: TextStyle(color: subtitleColor),
                            ),
                          Text(
                            'Status: ${book['status'] == 1 ? 'Active' : 'Inactive'}',
                            style: TextStyle(color: subtitleColor),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDelete(book['id']);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this book?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteBook(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
