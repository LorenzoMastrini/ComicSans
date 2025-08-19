import 'package:comicsans/global_constants.dart';
import 'package:comicsans/user.dart';

class Comic {
  int id;
  User seller;
  String title;
  String description;
  double price;
  double? offerPrice;
  Conditions conditions;
  String? coverPath;
  List<String> otherImagesPath;
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
    this.offerPrice,
    required this.conditions,
    this.otherImagesPath = const [],
    this.coverPath,
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

