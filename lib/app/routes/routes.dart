import 'package:edu_app/features/auth/views/screens/welcome.dart';
import 'package:go_router/go_router.dart';

GoRoute homeRoute = GoRoute(
  path: '/',
  name: 'Home',
  builder: (context, state) => WelcomeScreen(),
);

// Route list
List<GoRoute> routes = [homeRoute];
