import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/review.dart';



extension GenderExtension on Gender {
  String get label {
    switch (this) {
      case Gender.maschio:
        return 'Maschio';
      case Gender.femmina:
        return 'Femmina';
      case Gender.altro:
        return 'Altro';
    }
  }
}

class User{
  int? id;
  String username;
  String? name;
  String? lastName;
  String? email;
  String? password;
  String? imagePath;
  Gender? gender;
  String? birthday;
  Address? address;
  CreditCard? card;
  List<Comic> comicsSale;
  List<Comic> favouriteComics;
  List<User> followedUsers;
  List<Review> reviews;
  int rating;
  List<Comic> sellings;
  List<Comic> purchases;
  bool connectedAccount;

  User({
    this.id,
    required this.username,
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.imagePath,
    this.gender,
    this.birthday,
    this.address,
    this.card,
    required this.comicsSale,
    required this.favouriteComics,
    required this.followedUsers,
    required this.rating,
    required this.sellings,
    required this.purchases,
    required this.reviews,
    required this.connectedAccount
  });

  List<Comic> getComicsSale(){
    return comicsSale;
  }

  static List<Gender> getAllGenders(){
    return Gender.values;
  }
}



class Address{
  String name;
  String lastName;
  String country;
  String address;
  int cap;

  Address({
    this.name = "",
    this.lastName = "",
    this.country = "",
    this.address = "",
    this.cap = 0,
  });
}



class CreditCard{
  String holder;
  int number;
  String expiration;
  int cvv;

  CreditCard({
    this.holder = "",
    this.number = 0,
    this.expiration = "",
    this.cvv = 0
  });
}

User application = User(
    id: 0,
    username: "application",
    comicsSale: [],
    favouriteComics: [],
    followedUsers: [],
    rating: 0,
    sellings: [],
    purchases: [],
    reviews: [],
    connectedAccount: false
);