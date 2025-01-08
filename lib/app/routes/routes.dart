import 'package:edu_app/features/auth/views/screens/login.dart';
import 'package:edu_app/features/auth/views/screens/register.dart';
import 'package:edu_app/features/auth/views/screens/welcome.dart';
import 'package:edu_app/features/quiz/views/screens/quiz_list.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/features/textbook/models/chapter.dart';
import 'package:edu_app/features/textbook/views/screens/book_details.dart';
import 'package:edu_app/features/textbook/views/screens/book_list_view.dart';
import 'package:edu_app/features/textbook/views/screens/book_reading.dart';
import 'package:edu_app/features/textbook/views/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

GoRoute welcomeRoute = GoRoute(
  path: '/welcome',
  name: 'Welcome',
  pageBuilder: (context, state) =>
      _buildPageWithAnimation(state, WelcomeScreen()),
);

GoRoute registerRoute = GoRoute(
  path: '/register',
  name: 'Register',
  pageBuilder: (context, state) =>
      _buildPageWithAnimation(state, RegisterScreen()),
);

GoRoute loginRoute = GoRoute(
  path: '/login',
  name: 'Login',
  pageBuilder: (context, state) =>
      _buildPageWithAnimation(state, LoginScreen()),
);

GoRoute homeRoute = GoRoute(
  path: '/',
  name: 'Home',
  pageBuilder: (context, state) => _buildPageWithAnimation(state, HomeScreen()),
);

GoRoute bookDetailRoute = GoRoute(
  path: '/books/detail',
  name: 'BookDetail',
  pageBuilder: (context, state) =>
      _buildPageWithAnimation(state, BookDetailsScreen(state.extra as Book)),
);

GoRoute chapterDetailRoute = GoRoute(
  path: '/chapter/detail',
  name: 'ChapterDetail',
  pageBuilder: (context, state) {
    Map<String, dynamic> args = state.extra as Map<String, dynamic>;
    Book book = args['book'];
    Chapter chapter = args['chapter'];
    return _buildPageWithAnimation(state, ChapterReaderScreen(book, chapter));
  },
);

GoRoute quizList = GoRoute(
  path: '/quiz-list',
  name: 'Quiz List',
  pageBuilder: (context, state) => _buildPageWithAnimation(state, QuizList()),
);

GoRoute bookListRoute = GoRoute(
  path: '/library',
  name: 'Library',
  pageBuilder: (context, state) =>
      _buildPageWithAnimation(state, BookListView()),
);

// Route list
List<GoRoute> routes = [
  homeRoute,
  registerRoute,
  loginRoute,
  welcomeRoute,
  quizList,
  bookDetailRoute,
  bookListRoute,
  chapterDetailRoute
];

Page<dynamic> _buildPageWithAnimation(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0), // Starting position
          end: Offset.zero, // Final position
        ).animate(animation),
        child: child,
      ),
    ),
  );
}
