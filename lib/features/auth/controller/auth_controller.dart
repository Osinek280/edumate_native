import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/services/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(ref.read(AuthServiceProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthService _authService;

  AuthController(this._authService) : super(false);

  void loginUser(String email, String password, BuildContext context) async {
    state = true;
    try {
      final token = await _authService.login(email, password);
      print('Zalogowano: $token');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Zalogowano pomyślnie')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login nie działa: $e')));
    }
    state = false;
  }
}
