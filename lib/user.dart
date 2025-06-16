import 'package:comicsans/address.dart';
import 'package:comicsans/credit_card.dart';

enum Gender {Maschio, Femmina, Altro}
class User{
  String name;
  String lastName;
  String email;
  String password;
  String? imagePath;
  Gender? gend;
  String? birthday;
  Address addr;
  CreditCard card;

  User(
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.imagePath,
    this.gend,
    this.birthday,
    this.addr,
    this.card,
  );
}