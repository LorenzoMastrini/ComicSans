import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';



class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => ReviewWidgetState();
}



class ReviewWidgetState extends State<ReviewWidget> {
  List<Widget> printStar(int review){
    List<Widget> stars = [];
    for(int i = 0; i < 5; i++){
      if(i < review){
        stars.add(Icon(FontAwesomeIcons.solidStar, color: Colors.amberAccent, size: 18));
      }
      else{
        stars.add(Icon(FontAwesomeIcons.star, color: Colors.black, size: 18));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatch = context.watch<UserProvider>();

    return Row(
      children: [
        ...printStar(userProviderWatch.loggedInUser!.rating)
      ]
    );
  }
}