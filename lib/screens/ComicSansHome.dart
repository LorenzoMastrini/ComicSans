import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/screens/ComicSansFavorite.dart';
import 'package:comicsans/screens/ComicSansInbox.dart';
import 'package:comicsans/screens/ComicSansProfile.dart';
import 'package:comicsans/Components/app_bar.dart';
import 'package:comicsans/Components/product_grid.dart';
import 'package:comicsans/Components/search_bar_favourite.dart';
import 'package:comicsans/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/categories_grid.dart';
import 'package:comicsans/Components/search_bar.dart' hide SearchBar;
import '../Components/favourite_grid.dart';
import '../sample_data.dart';
import '../user.dart';


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
  int _selectedTabIndex = 0;
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
    final List<Widget> _pages = <Widget>[
      SingleChildScrollView(
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
      Container(color: Colors.blue),
      Container(color: Colors.yellow),
      Profile(user: widget.user),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: IndexedStack(
        index: _selectedTabIndex,
        children: _pages
      ),
    );
  }
}