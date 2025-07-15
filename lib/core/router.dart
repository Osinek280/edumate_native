import 'package:edumate_native/core/main_scaffold.dart';
import 'package:edumate_native/data/services/book_service.dart';
import 'package:edumate_native/features/auth/controller/auth_controller.dart';
import 'package:edumate_native/features/auth/presentation/login_screen.dart';
import 'package:edumate_native/features/auth/presentation/profile_screen.dart';
import 'package:edumate_native/features/book/presentation/book_list.dart';
import 'package:edumate_native/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final authState = ref.watch(authControllerProvider);
      final goingToLogin = state.uri.toString() == '/login';

      if (authState.isLoading) return null;

      if (!authState.loggedIn && !goingToLogin) return '/login';
      if (authState.loggedIn && goingToLogin) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => MyHomePage(title: "My Home Page"),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) {
              return Consumer(
                builder: (context, ref, _) {
                  ref.refresh(booksProvider);
                  return const BooksScreen();
                },
              );
            },
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
