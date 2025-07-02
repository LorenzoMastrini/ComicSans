import 'package:comicsans/user.dart';

class Review{
  int stars;
  String description;
  User user;

  Review({
   required this.stars,
   required this.description,
   required this.user
  });
}
