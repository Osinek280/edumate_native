import 'package:edumate_native/core/main_scaffold.dart';
import 'package:edumate_native/features/auth/presentation/login_screen.dart';
import 'package:edumate_native/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(String? token) {
  return GoRouter(
    initialLocation: token == null ? '/login' : '/home',
    redirect: (context, state) {
      final loggedIn = token != null && token.isNotEmpty;
      final goingToLogin = state.uri.toString() == '/login';

      if (!loggedIn && !goingToLogin) return '/login';
      if (loggedIn && goingToLogin) return '/home';
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
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text('Search')),
              body: const Center(child: Text('Search Screen')),
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text("Profile")),
              body: const Center(child: Text('Profile Screen')),
            ),
          ),
        ],
      ),
    ],
  );
}
