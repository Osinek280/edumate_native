import 'package:edumate_native/core/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/services/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref.read(AuthServiceProvider));
  },
);

class AuthState {
  final bool loggedIn;
  final bool isLoading;

  const AuthState({required this.loggedIn, required this.isLoading});

  AuthState copyWith({bool? loggedIn, bool? isLoading}) {
    return AuthState(
      loggedIn: loggedIn ?? this.loggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthController(this._authService)
    : super(const AuthState(loggedIn: false, isLoading: true)) {
    _checkToken(); // sprawdzamy od razu przy starcie czy już zalogowany
  }

  Future<void> _checkToken() async {
    final token = await TokenStorage.getToken();
    final isValid = token != null && token.isNotEmpty;
    state = AuthState(loggedIn: isValid, isLoading: false);
  }

  void loginUser(String email, String password, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final token = await _authService.login(email, password);
      await TokenStorage.saveToken(token);
      state = state.copyWith(loggedIn: true, isLoading: false);
      context.go('/home');
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // pokaz komunikat o błędzie jak chcesz
    }
  }

  void logout(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      await TokenStorage.clearToken();
      state = state.copyWith(loggedIn: false, isLoading: false);
      context.go('/login');
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // pokaz komunikat o błędzie jak chcesz
    }
  }
}
