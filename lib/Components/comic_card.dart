import 'package:comicsans/comic.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/user.dart';


class ComicCard extends StatefulWidget{
  final Comic comic;
  final User user;
  const ComicCard ({required this.comic, required this.user});

  @override
  State<ComicCard> createState() => _ComicCardState();
}

class _ComicCardState extends State<ComicCard> {
  late bool isFavourite;

  @override
  void initState(){
    super.initState();
    //isFavourite = widget.user.checkFavourites(widget.user, widget.comic);
  }

  void toggleFavourite(){
    setState(() {
      if(isFavourite){
        widget.user.removeFavourite(widget.comic);
      }
      else{
        widget.user.addFavourite(widget.comic);
      }
      isFavourite = !isFavourite;
    });
  }
  @override
  Widget build(BuildContext context){
    isFavourite = widget.user.checkFavourites(widget.user, widget.comic);
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
                      icon: isFavourite ? Icon(Icons.bookmark, color: Colors.white) : Icon(Icons.bookmark_border, color: Colors.white),
                      onPressed: () async {
                        if (isFavourite) {
                          bool? confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text("Sei sicuro di voler rimuovere questo fumetto dai preferiti?"),
                              actions: [
                                TextButton(
                                  child: Text("Annulla"),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: Text("Conferma"),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            toggleFavourite();
                          }
                        }
                        else {
                          toggleFavourite(); // aggiunta diretta senza conferma
                        }
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
