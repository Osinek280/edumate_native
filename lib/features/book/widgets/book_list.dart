import 'package:edumate_native/data/models/book.dart';
import 'package:edumate_native/features/book/widgets/book_card.dart';
import 'package:flutter/material.dart';
// import '../../controllers/search_controller.dart';
// import 'book_card.dart';
// import 'empty_states.dart';
// import 'loading_states.dart';

class BookList extends StatelessWidget {
  final List<Book> books;
  final String searchQuery;
  final bool isSearching;

  const BookList({
    super.key,
    required this.books,
    required this.searchQuery,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    // Jeśli trwa wyszukiwanie, pokaż loading
    if (isSearching) {
      return const _SearchingView();
    }

    // Jeśli brak książek i brak wyszukiwania, pokaż empty state
    if (books.isEmpty && searchQuery.isEmpty) {
      return const _EmptyState();
    }

    // Jeśli brak wyników wyszukiwania
    if (books.isEmpty && searchQuery.isNotEmpty) {
      return _NoSearchResults(searchQuery: searchQuery);
    }

    return CustomScrollView(
      slivers: [
        if (searchQuery.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    'Znaleziono ${books.length} ${_getBookCountText(books.length)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'dla: "$searchQuery"',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final book = books[index];
              return BookCard(book: book);
            }, childCount: books.length),
          ),
        ),
      ],
    );
  }

  String _getBookCountText(int count) {
    if (count == 1) return 'książkę';
    if (count >= 2 && count <= 4) return 'książki';
    return 'książek';
  }
}

class _SearchingView extends StatelessWidget {
  const _SearchingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
          ),
          SizedBox(height: 16),
          Text(
            'Wyszukiwanie...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoSearchResults extends StatelessWidget {
  final String searchQuery;

  const _NoSearchResults({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.search_off,
              size: 64,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Brak wyników wyszukiwania',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nie znaleziono książek dla: "$searchQuery"',
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Spróbuj wyszukać inną frazę',
            style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.library_books_outlined,
              size: 64,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Brak książek w bibliotece',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Dodaj pierwszą książkę do swojej kolekcji',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}
