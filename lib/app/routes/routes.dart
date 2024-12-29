import 'package:edu_app/features/auth/views/screens/login.dart';
import 'package:edu_app/features/auth/views/screens/register.dart';
import 'package:edu_app/features/auth/views/screens/welcome.dart';
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

// Route list
List<GoRoute> routes = [homeRoute, registerRoute, loginRoute, welcomeRoute];
