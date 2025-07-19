import 'package:edumate_native/data/models/book.dart';
import 'package:edumate_native/features/book/controller/book_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider dla aktualnego query
final searchQueryProvider = StateProvider<String>((ref) => '');

final debouncedSearchProvider = FutureProvider<List<Book>>((ref) async {
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) {
    // Jeśli brak query, pobierz wszystkie książki
    return ref.read(booksProvider.future);
  }

  // Symulacja debounce - możesz dostosować czas
  await Future.delayed(const Duration(milliseconds: 300));

  // Sprawdź czy query się nie zmieniło podczas debounce
  final currentQuery = ref.read(searchQueryProvider);
  if (currentQuery != query) {
    throw Exception('Query changed during debounce');
  }

  // Tutaj zaimplementuj wywołanie do bazy danych z filtrem
  // Na razie używamy lokalnego filtrowania, ale możesz to zastąpić
  // rzeczywistym zapytaniem do API/bazy danych
  final allBooks = await ref.read(booksProvider.future);

  return allBooks.where((book) {
    final searchLower = query.toLowerCase();
    return book.title.toLowerCase().contains(searchLower) ||
        book.authors.toLowerCase().contains(searchLower) ||
        book.isbn.toLowerCase().contains(searchLower);
  }).toList();
});
