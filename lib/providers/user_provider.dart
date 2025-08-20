import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class UserProvider extends ChangeNotifier {
  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;
  set loggedInUser (User? user) { // Called at login
      _loggedInUser = user;
      notifyListeners();
  }

  bool _justPurchased = false;
  bool get justPurchased => _justPurchased;
  void setJustPurchased (bool value) {
    _justPurchased = value;
    notifyListeners();
  }

  // favorite comics for the current user
  List<Comic> getFavoriteComics() {
    if (_loggedInUser == null) {
      return []; // If no user is logged in, don't return anything
    }

    return _loggedInUser!.favouriteComics;
  }

  void addFavorite(Comic newFavorite) {
    _loggedInUser!.favouriteComics.add(newFavorite);
    notifyListeners();
  }

  void removeFavorite(Comic favoriteToRemove) {
    _loggedInUser!.favouriteComics.remove(favoriteToRemove);
    notifyListeners();
  }

  int getNumberFavoriteComics() {
    return _loggedInUser!.favouriteComics.length;
  }

  bool checkFavorite(Comic comic){
    return _loggedInUser!.favouriteComics.contains(comic) ? true : false;
  }

  // Followed users
  List<User> getFollowedUsers() {
    return _loggedInUser!.followedUsers;
  }

  int getNumberOfFollowedUsers() {
    return _loggedInUser!.followedUsers.length;
  }

  void addFollowing(User user){
    _loggedInUser!.followedUsers.add(user);
  }
  void removeFollowing(User user){
    _loggedInUser!.followedUsers.remove(user);
  }

  List<Comic> getPurchasableComics(BuildContext context) {
    final comicsProvider = context.watch<ComicsProvider>();

    if (_loggedInUser == null) {
      return []; // If no user is logged in, don't return anything
    }

    return comicsProvider.allComics.where((comic) => comic.seller.id != _loggedInUser!.id).toList();
  }

  // Library handling
  List<Comic> getLibrary() {
    if (_loggedInUser != null) {
      return _loggedInUser!.comicsSale;
    } else {
      return [];
    }
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

  int getLibraryLength() {
    if (_loggedInUser != null) {
      return _loggedInUser!.comicsSale.length;
    } else {
      return 0;
    }
  }

  void updatePurchases(Comic newPurchase) {
    _loggedInUser!.purchases.add(newPurchase);
    notifyListeners();
  }

  List<Comic> getSales(){
    return _loggedInUser!.sellings;
  }

  int getNumberOfSales(){
    return _loggedInUser!.sellings.length;
  }

  List<Comic> getPurchases() {
    return _loggedInUser!.purchases;
  }

  int getNumberOfPurchases(){
    return _loggedInUser!.purchases.length;
  }

  int getNumberOfReviews(){
    if (_loggedInUser == null) {
      return 0; // If no user is logged in, don't return anything
    }

    return _loggedInUser!.reviews.length;
  }

  void resetInformations() {
    _loggedInUser = null;
    _justPurchased = false;
    notifyListeners();
  }
}