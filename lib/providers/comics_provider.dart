import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';



class ComicsProvider extends ChangeNotifier {
  // List of all comics available (from all users)
  final List<Comic> _allComics = [];
  List<Comic> get allComics => List.unmodifiable(_allComics);

  void initComicsList(List<Comic> comics) {
    _allComics.addAll(comics);
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



  // favorite comics for the current user
  final List<Comic> _favorite = [];
  List<Comic> get favorite => List.unmodifiable(_favorite);

  void addFavorite(Comic newFavorite) {
    _favorite.add(newFavorite);
    notifyListeners();
  }

  void removeFavorite(Comic favoriteToRemove) {
    _favorite.remove(favoriteToRemove);
    notifyListeners();
  }

  bool checkFavorite(Comic comic){
    return _favorite.contains(comic) ? true : false;
  }
}