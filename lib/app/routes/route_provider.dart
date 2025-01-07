import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: authState != null ? homeRoute.path : welcomeRoute.path,
    routes: routes,
  );
});
