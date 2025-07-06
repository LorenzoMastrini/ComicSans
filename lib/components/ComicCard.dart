import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class ComicCard extends StatefulWidget{
  final Comic comic;
  final User user;
  const ComicCard ({super.key, required this.comic, required this.user});

  @override
  State<ComicCard> createState() => _ComicCardState();
}



class _ComicCardState extends State<ComicCard> {
  late bool isFavourite;

  @override
  void initState(){
    super.initState();
  }

  void toggleFavourite(){
    final provider = context.read<ComicsProvider>();

    setState(() {
      if(isFavourite) {
        provider.removeFavorite(widget.comic);
      }
      else{
        provider.addFavorite(widget.comic);
      }
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context){
    final provider = context.watch<ComicsProvider>();
    isFavourite = provider.checkFavorite(widget.comic);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Stack(
        children: <Widget>[
          SizedBox(
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
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
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
                              "${widget.comic.price}€",
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
                        toggleFavourite(); // Adding is direct, without confirmation
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
