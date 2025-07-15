import 'package:dio/dio.dart';
import 'package:edumate_native/data/models/book.dart';
import 'package:edumate_native/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookService {
  final DioClient _client = DioClient();

  Future<List<Book>> get() async {
    try {
      final res = await _client.get('/api/books');
      final List<dynamic> data = res.data;
      return data.map((json) => Book.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Coś sie zjebało: ${e.response?.data}');
    }
  }
}

final BookServiceProvider = Provider<BookService>((ref) {
  return BookService();
});

final booksProvider = FutureProvider<List<Book>>((ref) async {
  final service = ref.read(BookServiceProvider);
  return service.get();
});
