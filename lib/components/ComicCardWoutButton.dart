import 'package:comicsans/comic.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/user.dart';


class ComicCardWoutButton extends StatefulWidget{
  final Comic comic;
  final User user;
  const ComicCardWoutButton ({required this.comic, required this.user});

  @override
  State<ComicCardWoutButton> createState() => _ComicCardWoutButtonState();
}

class _ComicCardWoutButtonState extends State<ComicCardWoutButton> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    widget.comic.cover ?? "assets/no_image.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7.0),
                      topLeft: Radius.circular(7.0),
                      bottomLeft: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                    ),
                  ),
                  child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 3, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        widget.comic.title,
                                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 3, 0, 3),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        widget.comic.price.toString() + "€",
                                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ]
        )
    );
  }
}
