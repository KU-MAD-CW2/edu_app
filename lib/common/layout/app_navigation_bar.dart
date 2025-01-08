import 'package:edu_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class AppNavigationBar extends StatefulWidget {
  final int currentIndex;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  _AppNavigationBarState createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;

  Map<int, GoRoute> routes = {
    0: homeRoute,
    1: quizList,
    2: homeRoute,
    3: bookListRoute,
    4: homeRoute
  };

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.replaceNamed(routes[index]?.name as String);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome05,
                color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                size: 30.0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedQuiz02,
                color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                size: 30.0,
              ),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedAllBookmark,
                color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                size: 30.0,
              ),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedLibraries,
                color: _selectedIndex == 3 ? Colors.red : Colors.grey,
                size: 30.0,
              ),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: _selectedIndex == 4 ? Colors.red : Colors.grey,
                size: 30.0,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
