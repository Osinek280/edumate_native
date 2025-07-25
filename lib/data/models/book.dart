class Book {
  final int id;
  final String title;
  final String isbn;
  final String authors;
  final String coverImage;

  Book({
    required this.id,
    required this.title,
    required this.isbn,
    required this.authors,
    required this.coverImage,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      isbn: json['isbn'],
      authors: json['authors'],
      coverImage: json['coverImage'],
    );
  }
}
