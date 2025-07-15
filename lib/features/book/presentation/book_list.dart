import 'dart:convert';
import 'package:edumate_native/data/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edumate_native/data/models/book.dart';

class BooksScreen extends ConsumerWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('📚 Książki — Przegląd GYATów')),
      body: booksAsync.when(
        data: (books) => _BookList(books: books),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('💥 Coś jebło: $err')),
      ),
    );
  }
}

class _BookList extends StatelessWidget {
  final List<Book> books;

  const _BookList({required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Center(child: Text('🫠 Brak książek... system ugotowany'));
    }

    return ListView.separated(
      itemCount: books.length,
      padding: const EdgeInsets.all(12),
      separatorBuilder: (_, __) => const Divider(height: 20),
      itemBuilder: (context, index) {
        final book = books[index];
        return ListTile(
          leading: _buildCoverImage(book.coverImage),
          title: Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${book.authors}\nISBN: ${book.isbn}',
            style: const TextStyle(fontSize: 12),
          ),
          isThreeLine: true,
          onTap: () {
            // przyszłościowo: szczegóły książki
          },
        );
      },
    );
  }

  Widget _buildCoverImage(String coverImage) {
    if (coverImage.isEmpty) {
      return const Icon(Icons.book_outlined);
    }

    final isBase64 = !_isProbablyUrl(coverImage);

    if (isBase64) {
      try {
        return Image.memory(
          base64Decode(coverImage),
          width: 50,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
        );
      } catch (e) {
        debugPrint('❌ Błąd dekodowania base64: $e');
        return const Icon(Icons.broken_image);
      }
    }

    return Image.network(
      coverImage,
      width: 50,
      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
    );
  }

  bool _isProbablyUrl(String str) {
    // Biedna, ale skuteczna heurystyka
    return str.startsWith('http://') || str.startsWith('https://');
  }
}
