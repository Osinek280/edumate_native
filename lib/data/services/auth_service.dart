import 'package:dio/dio.dart';
import 'package:edumate_native/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final DioClient _client = DioClient();

  Future<String> register(String email, String password) async {
    try {
      final res = await _client.post(
        '/register',
        data: {'email': email, 'password': password},
      );

      return res.data['token'];
    } on DioException catch (e) {
      throw Exception('Rejestracja nie przeszła: ${e.response?.data}');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final res = await _client.post(
        '/api/v1/auth/login',
        data: {'email': email, 'password': password},
      );
      return res.data['token'];
    } on DioException catch (e) {
      throw Exception('Login ujebany: ${e.response?.data}');
    }
  }
}

final AuthServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
