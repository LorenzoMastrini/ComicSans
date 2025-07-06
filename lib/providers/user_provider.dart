import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';



class UserProvider extends ChangeNotifier {
  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;
  set loggedInUser (User? user) { // Called at login
      _loggedInUser = user;
      notifyListeners();
  }

  void addComicToLibrary(Comic newComic) {
    if (_loggedInUser != null) {
      _loggedInUser!.comicsSale.add(newComic);
      notifyListeners();
    }
  }

  void removeComicFromLibrary(Comic comic) {
    if (_loggedInUser != null) {
      _loggedInUser!.comicsSale.remove(comic);
      notifyListeners();
    }
  }

  List<Comic> getLibrary() {
    if (_loggedInUser != null) {
      return _loggedInUser!.comicsSale;
    } else {
      return [];
    }
  }

  int getLibraryLength() {
    if (_loggedInUser != null) {
      return _loggedInUser!.comicsSale.length;
    } else {
      return 0;
    }
  }
}