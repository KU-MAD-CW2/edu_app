import 'package:edu_app/features/textbook/views/screens/book_list_view.dart';
import 'package:go_router/go_router.dart';

GoRoute homeRoute = GoRoute(
  path: '/',
  name: 'Home',
  builder: (context, state) => BookListView(),
);

// Route list
List<GoRoute> routes = [homeRoute];
