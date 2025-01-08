import 'package:edu_app/features/auth/views/screens/login.dart';
import 'package:edu_app/features/auth/views/screens/register.dart';
import 'package:edu_app/features/auth/views/screens/welcome.dart';
import 'package:edu_app/features/textbook/models/book.dart';
import 'package:edu_app/features/textbook/models/chapter.dart';
import 'package:edu_app/features/textbook/views/screens/book_details.dart';
import 'package:edu_app/features/textbook/views/screens/book_reading.dart';
import 'package:edu_app/features/textbook/views/screens/home.dart';
import 'package:go_router/go_router.dart';

GoRoute welcomeRoute = GoRoute(
  path: '/welcome',
  name: 'Welcome',
  builder: (context, state) => WelcomeScreen(),
);

GoRoute registerRoute = GoRoute(
  path: '/register',
  name: 'Register',
  builder: (context, state) => RegisterScreen(),
);

GoRoute loginRoute = GoRoute(
  path: '/login',
  name: 'Login',
  builder: (context, state) => LoginScreen(),
);

GoRoute homeRoute = GoRoute(
  path: '/',
  name: 'Home',
  builder: (context, state) => HomeScreen(),
);

GoRoute bookDetailRoute = GoRoute(
  path: '/books/detail',
  name: 'BookDetail',
  builder: (context, state) => BookDetailsScreen(state.extra as Book),
);

GoRoute chapterDetailRoute = GoRoute(
  path: '/chapter/detail',
  name: 'ChapterDetail',
  builder: (context, state) {
    Map<String, dynamic> args = state.extra as Map<String, dynamic>;
    Book book = args['book'];
    Chapter chapter = args['chapter'];
    return ChapterReaderScreen(book, chapter);
  },
);

// Route list
List<GoRoute> routes = [
  homeRoute,
  registerRoute,
  loginRoute,
  welcomeRoute,
  bookDetailRoute,
  chapterDetailRoute
];
