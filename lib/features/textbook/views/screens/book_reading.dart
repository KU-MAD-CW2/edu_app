import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/features/textbook/models/chapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';

class ChapterReaderScreen extends ConsumerStatefulWidget {
  final Book book;
  final Chapter chapter;

  const ChapterReaderScreen(this.book, this.chapter, {super.key});

  @override
  _ChapterReaderScreenState createState() => _ChapterReaderScreenState();
}

class _ChapterReaderScreenState extends ConsumerState<ChapterReaderScreen> {
  double percentage = 1;
  int _currentSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      appBarColor: Colors.grey.shade100,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.goNamed(bookDetailRoute.name as String,
                extra: widget.book),
          ),
          centerTitle: true,
          title: Text(widget.chapter.title,
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  percentage = double.parse(value);
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: '1',
                    child: Text('Small'),
                  ),
                  const PopupMenuItem(
                    value: '1.5',
                    child: Text('Medium'),
                  ),
                  const PopupMenuItem(
                    value: '2',
                    child: Text('Large'),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chapter.sections[_currentSectionIndex].title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 20 * percentage,
                    ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    widget.chapter.sections[_currentSectionIndex].content,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16 * percentage,
                        ),
                    customStylesBuilder: (element) {
                      return {'text-align': 'justify'};
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _currentSectionIndex > 0
                      ? () {
                          setState(() {
                            _currentSectionIndex--;
                          });
                        }
                      : null,
                ),
                Text(
                    'Section ${_currentSectionIndex + 1} of ${widget.chapter.sections.length}'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed:
                      _currentSectionIndex < widget.chapter.sections.length - 1
                          ? () {
                              setState(() {
                                _currentSectionIndex++;
                              });
                            }
                          : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
