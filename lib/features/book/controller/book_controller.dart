import 'package:edumate_native/data/models/book.dart';
import 'package:edumate_native/data/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksProvider = FutureProvider<List<Book>>((ref) async {
  final service = ref.read(BookServiceProvider);
  return service.get();
});

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:edumate_native/data/models/book.dart';
// import 'package:edumate_native/data/services/book_service.dart';

// // State dla kontrolera książek
// class BookState {
//   final List<Book> books;
//   final List<Book> filteredBooks;
//   final bool isLoading;
//   final bool isSearching;
//   final String searchQuery;
//   final String? error;

//   const BookState({
//     this.books = const [],
//     this.filteredBooks = const [],
//     this.isLoading = false,
//     this.isSearching = false,
//     this.searchQuery = '',
//     this.error,
//   });

//   BookState copyWith({
//     List<Book>? books,
//     List<Book>? filteredBooks,
//     bool? isLoading,
//     bool? isSearching,
//     String? searchQuery,
//     String? error,
//   }) {
//     return BookState(
//       books: books ?? this.books,
//       filteredBooks: filteredBooks ?? this.filteredBooks,
//       isLoading: isLoading ?? this.isLoading,
//       isSearching: isSearching ?? this.isSearching,
//       searchQuery: searchQuery ?? this.searchQuery,
//       error: error ?? this.error,
//     );
//   }
// }

// // Kontroler do zarządzania książkami
// class BookController extends StateNotifier<BookState> {
//   final BookService _bookService;

//   BookController(this._bookService) : super(const BookState());

//   // Pobieranie wszystkich książek
//   Future<void> loadBooks() async {
//     state = state.copyWith(isLoading: true, error: null);

//     try {
//       final books = await _bookService.get();
//       state = state.copyWith(
//         books: books,
//         filteredBooks: books,
//         isLoading: false,
//       );
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   // Wyszukiwanie książek z debounce
//   Future<void> searchBooks(String query) async {
//     // Aktualizuj query natychmiast
//     state = state.copyWith(searchQuery: query, isSearching: query.isNotEmpty);

//     if (query.isEmpty) {
//       // Jeśli brak query, pokaż wszystkie książki
//       state = state.copyWith(filteredBooks: state.books, isSearching: false);
//       return;
//     }

//     try {
//       // Symulacja debounce - w rzeczywistej aplikacji można użyć Timer
//       await Future.delayed(const Duration(milliseconds: 300));

//       // Sprawdź czy query się nie zmieniło
//       if (state.searchQuery != query) {
//         return; // Query się zmienił, przerwij wyszukiwanie
//       }

//       // Lokalnie filtruj książki
//       final filteredBooks = state.books.where((book) {
//         final searchLower = query.toLowerCase();
//         return book.title.toLowerCase().contains(searchLower) ||
//             book.authors.toLowerCase().contains(searchLower) ||
//             book.isbn.toLowerCase().contains(searchLower);
//       }).toList();

//       state = state.copyWith(filteredBooks: filteredBooks, isSearching: false);
//     } catch (e) {
//       state = state.copyWith(isSearching: false, error: e.toString());
//     }
//   }

//   // Dodawanie nowej książki
//   Future<void> addBook(Book book) async {
//     try {
//       // Dodaj książkę do listy lokalnie (w rzeczywistej aplikacji wywołaj API)
//       final updatedBooks = [...state.books, book];

//       state = state.copyWith(
//         books: updatedBooks,
//         filteredBooks: state.searchQuery.isEmpty
//             ? updatedBooks
//             : _filterBooks(updatedBooks, state.searchQuery),
//       );
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }

//   // Aktualizowanie książki
//   Future<void> updateBook(Book updatedBook) async {
//     try {
//       final updatedBooks = state.books.map((book) {
//         return book.id == updatedBook.id ? updatedBook : book;
//       }).toList();

//       state = state.copyWith(
//         books: updatedBooks,
//         filteredBooks: state.searchQuery.isEmpty
//             ? updatedBooks
//             : _filterBooks(updatedBooks, state.searchQuery),
//       );
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }

//   // Usuwanie książki
//   Future<void> deleteBook(String bookId) async {
//     try {
//       final updatedBooks = state.books
//           .where((book) => book.id != bookId)
//           .toList();

//       state = state.copyWith(
//         books: updatedBooks,
//         filteredBooks: state.searchQuery.isEmpty
//             ? updatedBooks
//             : _filterBooks(updatedBooks, state.searchQuery),
//       );
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }

//   // Resetowanie błędu
//   void clearError() {
//     state = state.copyWith(error: null);
//   }

//   // Prywatna metoda do filtrowania książek
//   List<Book> _filterBooks(List<Book> books, String query) {
//     if (query.isEmpty) return books;

//     final searchLower = query.toLowerCase();
//     return books.where((book) {
//       return book.title.toLowerCase().contains(searchLower) ||
//           book.authors.toLowerCase().contains(searchLower) ||
//           book.isbn.toLowerCase().contains(searchLower);
//     }).toList();
//   }
// }

// // Provider dla kontrolera książek
// final bookControllerProvider = StateNotifierProvider<BookController, BookState>(
//   (ref) {
//     final bookService = ref.watch(BookServiceProvider);
//     return BookController(bookService);
//   },
// );

// // Convenience providers dla łatwiejszego dostępu
// final booksListProvider = Provider<List<Book>>((ref) {
//   return ref.watch(bookControllerProvider).filteredBooks;
// });

// final isLoadingBooksProvider = Provider<bool>((ref) {
//   return ref.watch(bookControllerProvider).isLoading;
// });

// final isSearchingBooksProvider = Provider<bool>((ref) {
//   return ref.watch(bookControllerProvider).isSearching;
// });

// final bookSearchQueryProvider = Provider<String>((ref) {
//   return ref.watch(bookControllerProvider).searchQuery;
// });

// final bookErrorProvider = Provider<String?>((ref) {
//   return ref.watch(bookControllerProvider).error;
// });
