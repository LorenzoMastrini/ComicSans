import 'package:comicsans/components/ProductGrid.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/CategoriesGrid.dart';
import 'package:comicsans/components/ComicSansSearchBar.dart';
import 'package:comicsans/user.dart';



class ComicSansHome extends StatefulWidget {
  String title;
  bool purchaseConfirmed = false;
  User user;
  ComicSansHome({super.key, this.title = "", required this.user, this.purchaseConfirmed = false});

  @override
  State<ComicSansHome> createState() {
    return _ComicSansHomeState();
  }
}

class _ComicSansHomeState extends State<ComicSansHome> {
  @override
  void initState() {
    super.initState();
    if(widget.purchaseConfirmed){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Acquisto effettuato"),
            content: Text("Il tuo acquisto è andato a buon fine!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK")
              )
            ]
          )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MySearchBar(user: widget.user),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Esplora",
                      style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              CategoriesGrid(),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Consigliati per te",
                      style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              ProductGrid(user: widget.user),
            ],
          ),
        ),
      );
  }
}