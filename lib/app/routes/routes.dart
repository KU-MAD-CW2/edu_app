import 'package:edu_app/features/auth/views/screens/login.dart';
import 'package:edu_app/features/auth/views/screens/register.dart';
import 'package:edu_app/features/auth/views/screens/welcome.dart';
import 'package:edu_app/features/textbook/views/screens/add_book.dart';
import 'package:edu_app/features/textbook/views/screens/add_chapters.dart';
import 'package:edu_app/features/textbook/views/screens/admin_dash.dart';
import 'package:edu_app/features/textbook/views/screens/book_details.dart';
import 'package:edu_app/features/textbook/views/screens/home.dart';
import 'package:edu_app/features/textbook/views/screens/view_books.dart';
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
  builder: (context, state) => BookDetailsScreen(),
);

GoRoute addBookRoute = GoRoute(
  path: '/addbook',
  name: 'AddBook',
  builder: (context, state) => AddBookScreen(),
);

GoRoute adminDashRoute = GoRoute(
  path: '/admindash',
  name: 'AdminDash',
  builder: (context, state) => AdminDashScreen(),
);

GoRoute viewBooksRoute = GoRoute(
  path: '/viewbooks',
  name: 'ViewBooks',
  builder: (context, state) => ViewBooksScreen(),
);

GoRoute addChaptersRoute = GoRoute(
  path: '/addchapters',
  name: 'AddChapters',
  builder: (context, state) => AddChaptersScreen(),
);



// Route list
List<GoRoute> routes = [
  homeRoute,
  registerRoute,
  loginRoute,
  welcomeRoute,
  bookDetailRoute,
  addBookRoute,
  adminDashRoute,
  viewBooksRoute,
  addChaptersRoute
];
