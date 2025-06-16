import 'package:comicsans/user.dart';

String daEdicola = "Da edicola";
String ottime = "Ottime";
String buone = "Buone";
String moltoUsato = "Molto usato";

enum Conditions {daEdicola, ottime, buone, moltoUsato}
enum Genre {Avventura, Azione, Crime, Dramma, Fantasy, Horror, Poliziesco, Romantico, SciFi, Soprannaturale, Supereroi, Thriller, Umoristico, Altro}
enum binding {Spillato, Cartonato, Brossurato, Altro}

class Comic {
  int id;
  User seller;
  String title;
  String description;
  int price;
  Conditions cond;
  List<String> imagesPath;
  List<String>? authors;
  Genre? gen;
  int? publishYear;
  String? language;
  String? italianEditor;
  String? originalPublisher;
  String? series;
  String? originCountry;
  bool? variant;
  bool? graded;
  bool? signed;
  int? editionYear;
  int? isbn;

  Comic(
    this.id,
    this.seller,
    this.title,
    this.description,
    this.price,
    this.cond,
    this.imagesPath,
    this.authors,
    this.gen,
    this.publishYear,
    this.language,
    this.italianEditor,
    this.originalPublisher,
    this.series,
    this.originCountry,
    this.variant,
    this.graded,
    this.signed,
    this.editionYear,
    this.isbn,
  );
}

