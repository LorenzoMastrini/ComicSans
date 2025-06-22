import 'package:comicsans/comic.dart';
import 'package:flutter/material.dart';


class ComicCard extends StatefulWidget{
  final Comic comic;

  const ComicCard ({required this.comic});

  @override
  State<ComicCard> createState() => _ComicCardState();
}

class _ComicCardState extends State<ComicCard> {
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
                  widget.comic.coverPath,
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
                    IconButton(
                      icon: Icon(Icons.bookmark_border, color: Colors.white),
                      onPressed: () {
                        
                      },
                    )
                  ]
                ),
              ),
          ),
        ]
      )
    );
  }
}
