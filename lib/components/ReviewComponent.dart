import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comicsans/review.dart';

class ReviewComponent extends StatefulWidget{
  Review review;
  ReviewComponent({super.key, required this.review});

  @override
  State<ReviewComponent> createState() => _ReviewComponentState();
}



class _ReviewComponentState extends State<ReviewComponent> {
  List<Widget> printStar(int review) {
    List<Widget> stars = [];
    for(int i = 0; i < 5; i++){
      if(i < review){
        stars.add(Icon(FontAwesomeIcons.solidStar, color: Colors.amberAccent, size: 18));
      }
      else{
        stars.add(Icon(FontAwesomeIcons.star, color: Theme.of(context).colorScheme.secondary, size: 18));
      }
    }
    return stars;
  }
  
  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.account_circle, color: Theme.of(context).colorScheme.secondary, size: 70),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.review.user.username,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Row(
                  children: [
                    ...printStar(widget.review.stars)
                  ]
                )
              ]
            )
          ]
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(widget.review.description,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.normal
            )
          ),
        ),
        Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Theme.of(context).colorScheme.secondary),
      ]
      ),
    );
  }
}