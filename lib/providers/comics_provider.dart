import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/global_constants.dart';

enum SortType { none, alphabetical, price }
enum SortDirection {ascending, descending}



class ComicsProvider extends ChangeNotifier {
  // List of all comics available (from all users)
  final List<Comic> _allComics = [];
  List<Comic> get allComics => List.unmodifiable(_allComics);

  bool _initDone = false;
  List<Comic> get initDone => (_allComics);

  void initComicsList(List<Comic> comics) {
    if(!_initDone) {
      _allComics.addAll(comics);
      _initDone = true;
    }
    notifyListeners();
  }

  void addComic(Comic newComic) {
    _allComics.add(newComic);
    notifyListeners();
  }

  void removeComic(Comic comicToRemove) {
    _allComics.remove(comicToRemove);
    notifyListeners();
  }

  List<Comic> getPurchasableComics(User user) {
    return _allComics.where((comic) => comic.seller.id != user.id).toList();
  }

  List<Comic> getFavouriteComics(User user) {
    return user.favouriteComics;
  }

  //FILTERS
  double? _fromPrice;
  double? get fromPrice => _fromPrice;
  set fromPrice(double? value) {
    _fromPrice = value;
    notifyListeners();
  }

  double? _toPrice;
  double? get toPrice => _toPrice;
  set toPrice(double? value) {
    _toPrice = value;
    notifyListeners();
  }

  List<String> _authors = [];
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

  //conditions
  List<Conditions> _conditions = [];
  List<Conditions> get conditions => List.unmodifiable(_conditions);

  void updateConditions(Conditions condTitle, bool isSelected) {
    if (isSelected) {
      if (!_conditions.contains(condTitle)) {
        _conditions.add(condTitle);
      }
    } else {
      _conditions.remove(condTitle);
    }
    notifyListeners();
  }

  set conditions(List<Conditions> newConditions) {
    _conditions = List.from(newConditions);
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

  int? _fromPublicationYear;
  int? get fromPublicationYear => _fromPublicationYear;
  set fromPublicationYear(int? value) {
    _fromPublicationYear = value;
    notifyListeners();
  }

  int? _toPublicationYear;
  int? get toPublicationYear => _toPublicationYear;
  set toPublicationYear(int? value) {
    _toPublicationYear = value;
    notifyListeners();
  }

  int? _fromEditionYear;
  int? get fromEditionYear => _fromEditionYear;
  set fromEditionYear(int? value) {
    _fromEditionYear = value;
    notifyListeners();
  }

  int? _toEditionYear;
  int? get toEditionYear => _toEditionYear;
  set toEditionYear(int? value) {
    _toEditionYear = value;
    notifyListeners();
  }

  bool? _variant;
  bool? get variant => _variant;
  set variant(bool? value) {
    _variant = value;
    notifyListeners();
  }

  //bookbinding
  List<Binding> _binding = [];
  List<Binding> get binding => List.unmodifiable(_binding);

  void updateBinding(Binding bindTitle, bool isSelected) {
    if (isSelected) {
      if (!_binding.contains(bindTitle)) {
        _binding.add(bindTitle);
      }
    } else {
      _binding.remove(bindTitle);
    }
    notifyListeners();
  }

  set binding(List<Binding> newBinding) {
    _binding = List.from(newBinding);
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

  SortType _sortType = SortType.none;
  SortType get sortType => _sortType;
  set sortType(SortType value) {
    _sortType = value;
    notifyListeners();
  }

  SortDirection _sortDirection = SortDirection.ascending;
  SortDirection get sortDirection => _sortDirection;
  set sortDirection(SortDirection value) {
    _sortDirection = value;
    notifyListeners();
  }

  List<Comic> filterPurchasableComics(User? user, String? query){
    return getPurchasableComics(user!).where((comic){
      if(query != null && !comic.title.toLowerCase().contains(query.toLowerCase())) return false;

      //check price
      if(_fromPrice != null && comic.price < _fromPrice!) return false;
      if(_toPrice != null && comic.price > _toPrice!) return false;

      //check authors
      if(_authors.isNotEmpty && !_authors.any((author) => comic.authors.contains(author))) return false;

      //check genre
      if(_genre.isNotEmpty && !_genre.any((genre) => comic.genre.contains(genre))) return false;

      //check conditions
      if(_conditions.isNotEmpty && !_conditions.contains(comic.conditions)) return false;

      //check language
      if(_language != null && comic.language != _language) return false;

      //check italian publisher
      if(_italianPublisher != null && comic.italianPublisher != _italianPublisher) return false;

      //check original publisher
      if(_originalPublisher != null && comic.originalPublisher != _originalPublisher) return false;

      //check series
      if(_series != null && comic.series != _series) return false;

      //check country
      if(_country != null && comic.country != _country) return false;

      //check publication year
      if(_fromPublicationYear != null && comic.publicationYear! < _fromPublicationYear!) return false;
      if(_toPublicationYear != null && comic.publicationYear! > _toPublicationYear!) return false;

      //check edition year
      if(_fromEditionYear != null && comic.editionYear! < _fromEditionYear!) return false;
      if(_toEditionYear != null && comic.editionYear! > _toEditionYear!) return false;

      //check variant
      if(_variant != null && comic.variant != _variant) return false;

      //check binding
      if (_binding.isNotEmpty && !_binding.contains(comic.bookbinding)) return false;

      //check graded
      if(_graded != null && comic.graded != _graded) return false;

      //check signed
      if(_signed != null && comic.signed != _signed) return false;

      return true;
    }).toList();
  }

  List<Comic> filterFavouriteComics(User? user, String? query){
    return getFavouriteComics(user!).where((comic){
      if(query != null && !comic.title.toLowerCase().contains(query.toLowerCase())) return false;

      //check price
      if(_fromPrice != null && comic.price < _fromPrice!) return false;
      if(_toPrice != null && comic.price > _toPrice!) return false;

      //check authors
      if(_authors.isNotEmpty && !_authors.any((author) => comic.authors.contains(author))) return false;

      //check genre
      if(_genre.isNotEmpty && !_genre.any((genre) => comic.genre.contains(genre))) return false;

      //check conditions
      if(_conditions.isNotEmpty && !_conditions.contains(comic.conditions)) return false;

      //check language
      if(_language != null && comic.language != _language) return false;

      //check italian publisher
      if(_italianPublisher != null && comic.italianPublisher != _italianPublisher) return false;

      //check original publisher
      if(_originalPublisher != null && comic.originalPublisher != _originalPublisher) return false;

      //check series
      if(_series != null && comic.series != _series) return false;

      //check country
      if(_country != null && comic.country != _country) return false;

      //check publication year
      if(_fromPublicationYear != null && comic.publicationYear! < _fromPublicationYear!) return false;
      if(_toPublicationYear != null && comic.publicationYear! > _toPublicationYear!) return false;

      //check edition year
      if(_fromEditionYear != null && comic.editionYear! < _fromEditionYear!) return false;
      if(_toEditionYear != null && comic.editionYear! > _toEditionYear!) return false;

      //check variant
      if(_variant != null && comic.variant != _variant) return false;

      //check binding
      if (_binding.isNotEmpty && !_binding.contains(comic.bookbinding)) return false;

      //check graded
      if(_graded != null && comic.graded != _graded) return false;

      //check signed
      if(_signed != null && comic.signed != _signed) return false;

      return true;
    }).toList();
  }

  List<Comic> getPurchasableComicByISBN(User? user, int isbn){
    return getPurchasableComics(user!).where((comic){
      return comic.isbn == isbn;
    }).toList();
  }

  List<Comic> getFavouriteComicByISBN(User? user, int isbn){
    return getFavouriteComics(user!).where((comic){
      return comic.isbn == isbn;
    }).toList();
  }



  void resetInformations() {
    _fromPrice = null;
    _toPrice = null;
    _authors = [];
    _genre = [];
    _conditions = [];
    _language = null;
    _italianPublisher = null;
    _originalPublisher = null;
    _series = null;
    _country = null;
    _fromPublicationYear = null;
    _toPublicationYear = null;
    _fromEditionYear = null;
    _toEditionYear = null;
    _variant = null;
    _graded = null;
    _signed = null;
    _binding = [];
    _conditions = [];
    notifyListeners();
  }
}