import 'package:edu_app/app/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: bookDetailRoute.path,
    routes: routes,
  );
});
