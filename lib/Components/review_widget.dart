import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../comic.dart';

class ReviewWidget extends StatefulWidget {
  Comic comic;
  ReviewWidget({super.key, required this.comic});

  @override
  State<ReviewWidget> createState() => ReviewWidgetState();
}

printStar(int review){
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

class ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...printStar(widget.comic.seller!.rating)
      ]
    );
  }
}