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
}