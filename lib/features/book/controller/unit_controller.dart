import 'package:edumate_native/data/models/unit.dart';
import 'package:edumate_native/data/services/book_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final unitsProvider = FutureProvider.family<BookUnits, String>((
  ref,
  bookId,
) async {
  final service = ref.read(BookServiceProvider);
  return service.getUnits(bookId: bookId);
});
