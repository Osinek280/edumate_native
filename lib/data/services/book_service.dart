import 'package:dio/dio.dart';
import 'package:edumate_native/data/models/book.dart';
import 'package:edumate_native/data/models/unit.dart';
import 'package:edumate_native/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookService {
  final DioClient _client = DioClient();

  Future<List<Book>> getBooks({String? search}) async {
    try {
      final queryParameters = <String, dynamic>{};
      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }
      final res = await _client.get(
        '/api/books',
        queryParameters: queryParameters,
      );
      final List<dynamic> data = res.data as List;
      return data
          .map((json) => Book.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Coś sie zjebało: ${e.response?.data}');
    }
  }

  Future<BookUnits> getUnits({required String bookId}) async {
    try {
      final res = await _client.get('/api/books/$bookId/unit');

      final bookJson = res.data['book'];
      final book = BookBasic.fromJson(bookJson);

      List<dynamic> unitsJson = res.data['units'] ?? [];
      List<Unit> units = unitsJson
          .map((unitJson) => Unit.fromJson(unitJson))
          .toList();
      return BookUnits(book: book, units: units);
    } on DioException catch (e) {
      throw Exception('Coś sie zjebało: ${e.response?.data}');
    }
  }
}

final BookServiceProvider = Provider<BookService>((ref) {
  return BookService();
});
