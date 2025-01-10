import 'package:flutter/material.dart';
import '../../../../app/database/db_manager2.dart';
import '../../../../app/database/migrations2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_app/features/textbook/views/widgets/theme_provider.dart';

class AddChaptersScreen extends ConsumerStatefulWidget {
  const AddChaptersScreen({super.key});

  @override
  ConsumerState<AddChaptersScreen> createState() => _AddChaptersScreenState();
}

class _AddChaptersScreenState extends ConsumerState<AddChaptersScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final DBManager2 _dbManager2 = DBManager2();
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _chapters = [];
  final Map<int, List<Map<String, dynamic>>> _sections = {};
  int? _selectedBookId;
  final TextEditingController _sectionTitleController = TextEditingController();
  final TextEditingController _sectionContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final books = await _dbManager2.query(Migrations2.booksTable);
    setState(() {
      _books = books;
    });
  }

  Future<void> _fetchChapters() async {
    if (_selectedBookId != null) {
      final chapters = await _dbManager2.query(
        Migrations2.chaptersTable,
        where: 'book_id = ?',
        whereArgs: [_selectedBookId],
      );
      setState(() {
        _chapters = chapters;
      });

      for (var chapter in chapters) {
        await _fetchSections(chapter['id']);
      }
    }
  }

  Future<void> _fetchSections(int chapterId) async {
    final sections = await _dbManager2.query(
      Migrations2.sectionsTable,
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
    setState(() {
      _sections[chapterId] = sections;
    });
  }

  Future<void> _addChapter() async {
    if (_formKey.currentState!.validate() && _selectedBookId != null) {
      final chapterData = {
        'book_id': _selectedBookId!,
        'title': _titleController.text,
        'slug': _slugController.text.isNotEmpty
            ? _slugController.text
            : _titleController.text.toLowerCase().replaceAll(' ', '-'),
        'status': 0,
        'order_column': 0,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _dbManager2.insert(Migrations2.chaptersTable, chapterData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Chapter "${_titleController.text}" added successfully!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      _titleController.clear();
      _slugController.clear();
      _fetchChapters();
    }
  }
  
  Future<void> _addSectionWithContent(int chapterId, String title, String content) async {
  final sectionSlug = title.toLowerCase().replaceAll(' ', '-');
  
  final sectionData = {
    'chapter_id': chapterId,
    'title': title,
    'slug': sectionSlug,
    'content': content, 
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
  };

  await _dbManager2.insert(Migrations2.sectionsTable, sectionData);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Section "$title" added successfully!'),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  _fetchSections(chapterId);
}


  Future<void> _deleteSection(int sectionId, int chapterId) async {
    await _dbManager2.delete(
      Migrations2.sectionsTable,
      where: 'id = ?',
      whereArgs: [sectionId],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Section deleted successfully!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    _fetchSections(chapterId);
  }

  Future<void> _deleteChapter(int chapterId) async {
    await _dbManager2.delete(
      Migrations2.chaptersTable,
      where: 'id = ?',
      whereArgs: [chapterId],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Chapter deleted successfully!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    _fetchChapters();
  }

  @override
Widget build(BuildContext context) {
  final isDarkMode = ref.watch(themeProvider);

  Color textColor = isDarkMode ? Colors.white : Colors.black;
  Color backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;
  Color fieldColor = isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;

  return Scaffold(
  appBar: AppBar(
  title: Text(
    'Add Chapter & Sections',
    style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  elevation: 0,
  backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
  iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
),
  backgroundColor: backgroundColor, // Ensures the body background matches the mode
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _formKey,
      child: ListView(
        children: [
            DropdownButtonFormField<int>(
              value: _selectedBookId,
              decoration: InputDecoration(
                labelText: 'Select a Book',
                filled: true,
                fillColor: fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedBookId = value;
                });
                _fetchChapters();
              },
              items: _books.map((book) {
                return DropdownMenuItem<int>(
                  value: book['id'],
                  child: Text(book['title'], style: TextStyle(color: textColor)),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select a book';
                }
                return null;
              },
              dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white, // Change dropdown background color based on dark mode
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Chapter Title',
                filled: true,
                fillColor: fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              style: TextStyle(color: textColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the chapter title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addChapter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Add Chapter', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _chapters.length,
              itemBuilder: (context, index) {
                final chapter = _chapters[index];
                return ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chapter['title'], style: TextStyle(color: textColor)),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteChapter(chapter['id']),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add, color: Colors.indigo),
                    onPressed: () {
                      _sectionTitleController.clear();
                      _sectionContentController.clear(); // Clear the content field
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Add Section'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _sectionTitleController,
                                  decoration: const InputDecoration(labelText: 'Section Title'),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _sectionContentController,
                                  decoration: const InputDecoration(labelText: 'Section Content'),
                                  maxLines: 5, // Allow multiline input
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final sectionTitle = _sectionTitleController.text.trim();
                                  final sectionContent = _sectionContentController.text.trim();
                                  if (sectionTitle.isNotEmpty && sectionContent.isNotEmpty) {
                                    _addSectionWithContent(chapter['id'], sectionTitle, sectionContent);
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Please fill in both title and content'),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  children: (_sections[chapter['id']] ?? []).map<Widget>((section) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(section['title'], style: TextStyle(color: textColor)),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteSection(section['id'], chapter['id']),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}


