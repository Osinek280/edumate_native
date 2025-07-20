import 'package:edumate_native/data/models/book.dart';
import 'package:edumate_native/data/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider dla aktualnego query
final searchQueryProvider = StateProvider<String>((ref) => '');

final debouncedSearchProvider = FutureProvider<List<Book>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final bookService = ref.read(BookServiceProvider);

  if (query.isEmpty) {
    // Jeśli brak query, pobierz wszystkie książki
    return bookService.get();
  }

  // Symulacja debounce - możesz dostosować czas
  await Future.delayed(const Duration(milliseconds: 300));

  // Sprawdź czy query się nie zmieniło podczas debounce
  if (ref.read(searchQueryProvider) != query) {
    throw Exception('Query changed during debounce');
  }

  return bookService.get(search: query);
});
