import 'package:comicsans/SampleData.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



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
  String? _coverPath;
  String? get coverPath => _coverPath;
  void updateCover(String? newCoverPath) {
    _coverPath = newCoverPath;
    notifyListeners();
  }

  // Other photos
  List<String> _otherImagesPaths = [];
  List<String> get otherImagesPaths => List.unmodifiable(_otherImagesPaths);
  void setOtherImages(List<String> existingImagesPaths) {
    _otherImagesPaths = List.from(existingImagesPaths);
    notifyListeners();
  }

  void addPhoto(String newImagePath) {
    if (_otherImagesPaths.length >= 9) return;
    _otherImagesPaths.add(newImagePath);
    print(_otherImagesPaths);
    notifyListeners();
  }

  void replacePhotoAt(int index, String newImagePath) {
    if (index >= 0 && index < _otherImagesPaths.length) {
      _otherImagesPaths[index] = newImagePath;
      notifyListeners();
    }
  }

  void removePhotoAt(int index) {
    if (index >= 0 && index < _otherImagesPaths.length) {
      _otherImagesPaths.removeAt(index);
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
  List<Genre> _genre = [];
  List<Genre> get genre => List.unmodifiable(_genre);

  void updateGenre(Genre genreTitle, bool isSelected) {
    if (isSelected) {
      if (!_genre.contains(genreTitle)) {
        _genre.add(genreTitle);
      }
    } else {
      _genre.remove(genreTitle);
    }
    notifyListeners();
  }

  set genre(List<Genre> newGenres) {
    _genre = List.from(newGenres);
    notifyListeners();
  }

  // Language
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

  Binding? _bookbinding;
  Binding? get bookbinding => _bookbinding;
  set bookbinding(Binding? value) {
    _bookbinding = value;
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

  int? _isbn;
  int? get isbn => _isbn;
  set isbn(int? value) {
    _isbn = value;
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

  void resetInformations() {
    _title = null;
    _description = null;
    _price = null;
    _conditions = null;
    _coverPath = null;
    _otherImagesPaths.clear();
    _authors = [''];
    _genre = [];
    _language = null;
    _italianPublisher = null;
    _originalPublisher = null;
    _series = null;
    _country = null;
    _bookbinding = null;
    _publicationYear = null;
    _editionYear = null;
    _isbn = null;
    _variant = null;
    _graded = null;
    _signed = null;
    notifyListeners();
  }

  Comic createComic(BuildContext context) {
    return Comic (
      id: context.read<ComicsProvider>().allComics.length,
      seller: context.read<UserProvider>().loggedInUser!,
      title: _title!,
      description: _description!,
      price: _price!,
      conditions: _conditions!,
      coverPath: _coverPath!,
      otherImagesPath: List<String>.from(_otherImagesPaths),
      authors: authors,
      genre: genre,
      publicationYear: _publicationYear,
      editionYear: _editionYear,
      language: _language,
      italianPublisher: _italianPublisher,
      originalPublisher: _originalPublisher,
      series: _series,
      country: _country,
      variant: _variant,
      graded: _graded,
      signed: _signed,
      bookbinding: _bookbinding,
      isbn: _isbn,
    );
  }
}