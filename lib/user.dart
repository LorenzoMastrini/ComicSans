import 'package:comicsans/address.dart';
import 'package:comicsans/credit_card.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/Components//review_component.dart';
import 'package:comicsans/review.dart';

enum Gender {Maschio, Femmina, Altro}
class User{
  int? id;
  String username;
  String? name;
  String? lastName;
  String? email;
  String? password;
  String? imagePath;
  Gender? gend;
  String? birthday;
  Address? addr;
  CreditCard? card;
  List<Comic> comicsSale;
  List<Comic> favouriteComics;
  List<User> followedUsers;
  List<Review> reviews;
  int rating;
  List<Comic> sellings;
  List<Comic> purchases;

  User(
  {
    this.id,
    required this.username,
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.imagePath,
    this.gend,
    this.birthday,
    this.addr,
    this.card,
    required this.comicsSale,
    required this.favouriteComics,
    required this.followedUsers,
    required this.rating,
    required this.sellings,
    required this.purchases,
    required this.reviews
  });

  bool checkFavourites(User user, Comic comic){
    bool isFavourite = false;
    for(int i=0; i < user.favouriteComics!.length; i++){
      if(user.favouriteComics![i].id == comic.id){
        return isFavourite = true;
      }
    }
    return isFavourite;
  }
  void addFavourite(Comic comic){
    favouriteComics.add(comic);
  }
  void addFollowing(User user){
    followedUsers!.add(user);
  }
  void removeFollowing(User user){
    followedUsers!.remove(user);
  }
  void removeFavourite(Comic comic) {
    favouriteComics.remove(comic);
  }
  void removeComicsSale(Comic comic) {
    comicsSale.remove(comic);
  }
  List<Comic> getFavourites(){
    return favouriteComics;
  }
  List<Comic> getComicsSale(){
    return comicsSale;
  }
  List<Comic> getSellings(){
    return sellings;
  }
  List<Comic> getPurchases(){
    return purchases;
  }
}