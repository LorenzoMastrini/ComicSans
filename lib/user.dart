import 'package:comicsans/address.dart';
import 'package:comicsans/credit_card.dart';
import 'package:comicsans/comic.dart';

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
  List<Comic>? favouriteComics;
  List<User>? followedUsers;
  int rating;

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
    this.favouriteComics,
    this.followedUsers,
    required this.rating
  });
}