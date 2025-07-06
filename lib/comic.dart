import 'package:comicsans/global_constants.dart';
import 'package:comicsans/user.dart';



class Comic {
  int id;
  User seller;
  String title;
  String description;
  double price;
  Conditions conditions;
  String? cover;
  List<String> uploadedImages;
  List<String> authors;
  List<Genre> genre;
  int? publicationYear;
  String? language;
  String? italianPublisher;
  String? originalPublisher;
  String? series;
  String? country;
  bool? variant;
  bool? graded;
  bool? signed;
  Binding? bookbinding;
  int? editionYear;
  int? isbn;

  Comic({
    required this.id,
    required this.seller,
    required this.title,
    required this.description,
    required this.price,
    required this.conditions,
    this.uploadedImages = const [],
    this.cover,
    this.authors = const [],
    this.genre = const [],
    this.publicationYear,
    this.language,
    this.italianPublisher,
    this.originalPublisher,
    this.series,
    this.country,
    this.variant,
    this.graded,
    this.signed,
    this.bookbinding,
    this.editionYear,
    this.isbn,
  });
}

