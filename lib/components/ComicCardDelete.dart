import 'dart:io';

import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ComicCardDelete extends StatefulWidget{
  final Comic comic;
  final VoidCallback onDelete;

  const ComicCardDelete ({super.key, required this.comic, required this.onDelete});

  @override
  State<ComicCardDelete> createState() => _ComicCardDeleteState();
}


class _ComicCardDeleteState extends State<ComicCardDelete> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProviderRead = context.read<UserProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: widget.comic.coverPath!.startsWith('assets/')
                ? Image.asset(
                  widget.comic.coverPath!,
                  fit: BoxFit.fill
                )
                : widget.comic.coverPath!.isEmpty || !File(widget.comic.coverPath!).existsSync()
                  ? Image.asset('assets/no_image.png', fit: BoxFit.fill)
                  : Image.file(
                    File(widget.comic.coverPath!),
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
                              "${widget.comic.price}€",
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      showDialog<bool> (
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Sei sicuro di voler rimuovere questo annuncio?"),
                          actions: [
                            TextButton(
                              child: Text("Annulla"),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: Text("Conferma"),
                              onPressed: () {
                                userProviderRead.removeComicFromLibrary(widget.comic);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
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