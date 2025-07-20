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

// import 'dart:convert';

// Book bookFromJson(String str) => Book.fromJson(json.decode(str));

// String bookToJson(Book data) => json.encode(data.toJson());

// class Book {
//   List<Content> content;
//   Pageable pageable;
//   int totalElements;
//   int totalPages;
//   bool last;
//   int size;
//   int number;
//   Sort sort;
//   bool first;
//   int numberOfElements;
//   bool empty;

//   Book({
//     required this.content,
//     required this.pageable,
//     required this.totalElements,
//     required this.totalPages,
//     required this.last,
//     required this.size,
//     required this.number,
//     required this.sort,
//     required this.first,
//     required this.numberOfElements,
//     required this.empty,
//   });

//   factory Book.fromJson(Map<String, dynamic> json) => Book(
//     content: List<Content>.from(
//       json["content"].map((x) => Content.fromJson(x)),
//     ),
//     pageable: Pageable.fromJson(json["pageable"]),
//     totalElements: json["totalElements"],
//     totalPages: json["totalPages"],
//     last: json["last"],
//     size: json["size"],
//     number: json["number"],
//     sort: Sort.fromJson(json["sort"]),
//     first: json["first"],
//     numberOfElements: json["numberOfElements"],
//     empty: json["empty"],
//   );

//   Map<String, dynamic> toJson() => {
//     "content": List<dynamic>.from(content.map((x) => x.toJson())),
//     "pageable": pageable.toJson(),
//     "totalElements": totalElements,
//     "totalPages": totalPages,
//     "last": last,
//     "size": size,
//     "number": number,
//     "sort": sort.toJson(),
//     "first": first,
//     "numberOfElements": numberOfElements,
//     "empty": empty,
//   };
// }

// class Content {
//   int id;
//   String title;
//   String isbn;
//   String authors;
//   String coverImage;

//   Content({
//     required this.id,
//     required this.title,
//     required this.isbn,
//     required this.authors,
//     required this.coverImage,
//   });

//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//     id: json["id"],
//     title: json["title"],
//     isbn: json["isbn"],
//     authors: json["authors"],
//     coverImage: json["coverImage"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "isbn": isbn,
//     "authors": authors,
//     "coverImage": coverImage,
//   };
// }

// class Pageable {
//   int pageNumber;
//   int pageSize;
//   Sort sort;
//   int offset;
//   bool unpaged;
//   bool paged;

//   Pageable({
//     required this.pageNumber,
//     required this.pageSize,
//     required this.sort,
//     required this.offset,
//     required this.unpaged,
//     required this.paged,
//   });

//   factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
//     pageNumber: json["pageNumber"],
//     pageSize: json["pageSize"],
//     sort: Sort.fromJson(json["sort"]),
//     offset: json["offset"],
//     unpaged: json["unpaged"],
//     paged: json["paged"],
//   );

//   Map<String, dynamic> toJson() => {
//     "pageNumber": pageNumber,
//     "pageSize": pageSize,
//     "sort": sort.toJson(),
//     "offset": offset,
//     "unpaged": unpaged,
//     "paged": paged,
//   };
// }

// class Sort {
//   bool sorted;
//   bool empty;
//   bool unsorted;

//   Sort({required this.sorted, required this.empty, required this.unsorted});

//   factory Sort.fromJson(Map<String, dynamic> json) => Sort(
//     sorted: json["sorted"],
//     empty: json["empty"],
//     unsorted: json["unsorted"],
//   );

//   Map<String, dynamic> toJson() => {
//     "sorted": sorted,
//     "empty": empty,
//     "unsorted": unsorted,
//   };
// }
