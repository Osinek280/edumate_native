class Unit {
  final int id;
  final int unitNumber;
  final String wordlistImage;

  Unit({
    required this.id,
    required this.unitNumber,
    required this.wordlistImage,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      unitNumber: json['unitNumber'],
      wordlistImage: json['wordlistImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'unitNumber': unitNumber, 'wordlistImage': wordlistImage};
  }
}

class BookBasic {
  final int id;
  final String title;
  final String isbn;
  final String authors;

  BookBasic({
    required this.id,
    required this.title,
    required this.isbn,
    required this.authors,
  });

  factory BookBasic.fromJson(Map<String, dynamic> json) {
    return BookBasic(
      id: json['id'],
      title: json['title'],
      isbn: json['isbn'],
      authors: json['authors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isbn': isbn, 'authors': authors};
  }
}

class BookUnits {
  final BookBasic book;
  final List<Unit> units;

  BookUnits({required this.book, required this.units});
}
