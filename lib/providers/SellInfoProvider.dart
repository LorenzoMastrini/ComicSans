import 'dart:io';
import 'package:comicsans/comic.dart';
import 'package:flutter/cupertino.dart';



class SellInfoProvider extends ChangeNotifier {
  // BASIC INFORMATIONS
  String? _title;
  String? get title => _title;
  set title(String? value) {
    _title = value;
    notifyListeners();
  }

  String? _description;
  String? get description => _description;
  set description(String? value) {
    _description = value;
    notifyListeners();
  }

  double? _price;
  double? get price => _price;
  set price(double? value) {
    _price = value;
    notifyListeners();
  }

  Conditions? _conditions;
  Conditions? get conditions => _conditions;
  set conditions(Conditions? value) {
    _conditions = value;
    notifyListeners();
  }


  // PHOTOS
  // Cover photo
  File? cover;

  void updateCover(File? newCover) {
    cover = newCover;
    notifyListeners();
  }

  // Other photos
  List<File?> _uploadedImages = [];
  List<File?> get uploadedImages => List.unmodifiable(_uploadedImages);

  void addPhoto(File newImage) {
    if (_uploadedImages.length >= 9) return;
    _uploadedImages.add(newImage);
    notifyListeners();
  }

  void replacePhotoAt(int index, File newImage) {
    if (index >= 0 && index < _uploadedImages.length) {
      _uploadedImages[index] = newImage;
      notifyListeners();
    }
  }

  void removePhotoAt(int index) {
    if (index >= 0 && index < _uploadedImages.length) {
      _uploadedImages.removeAt(index);
      notifyListeners();
    }
  }


  // DETAILS
  // Authors
  List<String> _authors = [''];
  List<String> get authors => List.unmodifiable(_authors);

  void updateAuthor(int index, String value) {
    if (index >= 0 && index < authors.length) {
      _authors[index] = value;
      notifyListeners();
    }
  }

  void addAuthor(String author) {
    _authors.add(author);
    notifyListeners();
  }

  void removeAuthor(int index) {
    if (index >= 0 && index < authors.length) {
      _authors.removeAt(index);
      notifyListeners();
    }
  }

  set authors(List<String> newAuthors) {
    _authors = List.from(newAuthors);
    notifyListeners();
  }

  // Genres
  List<String> _genres = [];
  List<String> get genres => List.unmodifiable(_genres);

  void updateGenre(String genreTitle, bool isSelected) {
    if (isSelected) {
      if (!_genres.contains(genreTitle)) {
        _genres.add(genreTitle);
      }
    } else {
      _genres.remove(genreTitle);
    }
    notifyListeners();
  }

  set genres(List<String> newGenres) {
    _genres = List.from(newGenres);
    notifyListeners();
  }

  String? _language;
  String? get language => _language;
  set language(String? newLanguage) {
    _language = newLanguage;
    notifyListeners();
  }

  String? _italianPublisher;
  String? get italianPublisher => _italianPublisher;
  set italianPublisher(String? newItalianPublisher) {
    _italianPublisher = newItalianPublisher;
    notifyListeners();
  }

  String? _originalPublisher;
  String? get originalPublisher => _originalPublisher;
  set originalPublisher(String? value) {
    _originalPublisher = value;
    notifyListeners();
  }

  String? _series;
  String? get series => _series;
  set series(String? value) {
    _series = value;
    notifyListeners();
  }

  String? _country;
  String? get country => _country;
  set country(String? value) {
    _country = value;
    notifyListeners();
  }

  String? _bookbinding;
  String? get bookbinding => _bookbinding;
  set bookbinding(String? value) {
    _bookbinding = value;
    notifyListeners();
  }

  String? _isbn;
  String? get isbn => _isbn;
  set isbn(String? value) {
    _isbn = value;
    notifyListeners();
  }

  int? _publicationYear;
  int? get publicationYear => _publicationYear;
  set publicationYear(int? value) {
    _publicationYear = value;
    notifyListeners();
  }

  int? _editionYear;
  int? get editionYear => _editionYear;
  set editionYear(int? value) {
    _editionYear = value;
    notifyListeners();
  }

  bool? _variant;
  bool? get variant => _variant;
  set variant(bool? value) {
    _variant = value;
    notifyListeners();
  }

  bool? _graded;
  bool? get graded => _graded;
  set graded(bool? value) {
    _graded = value;
    notifyListeners();
  }

  bool? _signed;
  bool? get signed => _signed;
  set signed(bool? value) {
    _signed = value;
    notifyListeners();
  }
}