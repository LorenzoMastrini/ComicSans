import 'dart:io';
import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ComicCard extends StatelessWidget{
  final Comic comic;
  final bool showFavoriteButton;
  const ComicCard ({super.key, required this.comic, this.showFavoriteButton = true});

  void toggleFavourite(bool isFavorite, UserProvider provider){
    if(isFavorite) {
      provider.removeFavorite(comic);
    } else {
      provider.addFavorite(comic);
    }
  }

  @override
  Widget build(BuildContext context){
    final userProvider = context.watch<UserProvider>();
    final isFavorite = userProvider.isFavorite(comic);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: comic.coverPath.startsWith('assets/')
                ? Image.asset(
                  comic.coverPath,
                  fit: BoxFit.fill
                )
                : comic.coverPath.isEmpty || !File(comic.coverPath).existsSync()
                  ? Image.asset('assets/no_image.png', fit: BoxFit.fitHeight)
                  : Image.file(File(comic.coverPath), fit: BoxFit.fitHeight),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withAlpha(210),
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
                              comic.title,
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
                              "${comic.price}€",
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  showFavoriteButton
                    ? IconButton(
                        icon: isFavorite
                          ? Icon(Icons.bookmark, color: Theme.of(context).colorScheme.tertiary)
                          : Icon(Icons.bookmark_border, color: Theme.of(context).colorScheme.tertiary),
                      onPressed: () async {
                        if(isFavorite) {
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
                            toggleFavourite(isFavorite, userProvider);
                          }
                        } else {
                          toggleFavourite(isFavorite, userProvider); // Adding is direct, without confirmation
                        }
                      },
                    )
                    : Container()
                ]
              ),
            ),
          ),
        ]
      )
    );
  }
}
