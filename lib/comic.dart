import 'package:comicsans/user.dart';
enum Conditions {DaEdicola, Ottime, Buone, MoltoUsato}
enum Genre {Avventura, Azione, Crime, Dramma, Fantasy, Horror, Poliziesco, Romantico, SciFi, Soprannaturale, Supereroi, Thriller, Umoristico, Altro}
enum binding {Spillato, Cartonato, Brossurato, Altro}

class Comic {
  int id;
  User? seller;
  String title;
  String description;
  int price;
  Conditions cond;
  List<String> imagesPath;
  String coverPath;
  List<String> authors;
  List<Genre> gen;
  int? publishYear;
  String language;
  String italianEditor;
  String originalPublisher;
  String series;
  String originCountry;
  bool variant;
  bool graded;
  bool signed;
  int? editionYear;
  int? isbn;

  Comic({
    this.id = 0,
    this.seller,
    this.title = "",
    this.description = "",
    this.price = 1,
    this.cond = Conditions.DaEdicola,
    this.imagesPath = const [],
    this.coverPath = "",
    this.authors = const [],
    this.gen = const [],
    this.publishYear,
    this.language = "",
    this.italianEditor = "",
    this.originalPublisher = "",
    this.series = "",
    this.originCountry = "",
    this.variant = false,
    this.graded = false,
    this.signed = false,
    this.editionYear,
    this.isbn,
  });
}

