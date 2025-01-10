import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/database/db_manager2.dart';
import '../../../../app/database/migrations2.dart';
import 'package:edu_app/features/textbook/views/widgets/theme_provider.dart';

class AddBookScreen extends ConsumerStatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends ConsumerState<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final DBManager2 _dbManager2 = DBManager2();
  bool _isFeatured = false;
  int _status = 0;
  File? _selectedImage;
  String? _selectedCategory; // To hold the selected category

  // List of categories to display in the dropdown
  List<String> categories = ['Science', 'Math', 'History', 'Literature', 'Technology'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      final bookData = {
        'title': _titleController.text,
        'slug': _slugController.text.isNotEmpty
            ? _slugController.text
            : _titleController.text.toLowerCase().replaceAll(' ', '-'),
        'cover_image': _selectedImage?.path ?? '',
        'url': _urlController.text.isNotEmpty ? _urlController.text : null,
        'featured': _isFeatured ? 1 : 0,
        'status': _status,
        'category': _selectedCategory, // Add the category to the book data
        'published_at': DateTime.now().toIso8601String(),
      };

      await _dbManager2.insert(Migrations2.booksTable, bookData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book "${_titleController.text}" added successfully!')),
      );

      _titleController.clear();
      _slugController.clear();
      _urlController.clear();
      setState(() {
        _isFeatured = false;
        _status = 0;
        _selectedCategory = null;
        _selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);

    // Define the text color based on theme
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    Color fieldColor = isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Book',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigoAccent),
        ),
       // backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: Container(
       // color: backgroundColor, // Apply background color for the body
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Add a New Book',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Book Title',
                  filled: true,
                  fillColor: fieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
                style: TextStyle(color: textColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the book title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDarkMode ? Colors.grey : Colors.grey[400]!),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Text(
                            'Tap to select cover image',
                           // style: TextStyle(color: isDarkMode ? Colors.white60 : Colors.grey[600]),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured', style: TextStyle(fontSize: 16)),
                  Switch(
                    value: _isFeatured,
                    onChanged: (value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Status:', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 16),
                  DropdownButton<int>(
                    value: _status,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Inactive')),
                      DropdownMenuItem(value: 1, child: Text('Active')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                    dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Category Dropdown
              Row(
                children: [
                  Text('Category:', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    hint: Text('Select a Category'),
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Add Book', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

