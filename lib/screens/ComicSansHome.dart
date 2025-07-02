import 'package:comicsans/Components/app_bar.dart';
import 'package:comicsans/Components/product_grid.dart';
import 'package:comicsans/Components/search_bar_favourite.dart';
import 'package:comicsans/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/categories_grid.dart';
import 'package:comicsans/Components/search_bar.dart' hide SearchBar;
import '../Components/favourite_grid.dart';
import '../user.dart';


class ComicSansHome extends StatefulWidget {
  String title;
  User user;
  bool purchaseConfirmed = false;
  ComicSansHome({super.key, required this.title, required this.user, required this.purchaseConfirmed});

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
      SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ComicSansAppBar(title: "Preferiti", showBackButton: false),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: MySearchBarFavourite(user: widget.user)
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.filter_list, color: Colors.black, size: 30)
                      )
                    ]
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        FilterChip(
                          label: Text("Ordina per"),
                          selected: false,
                          onSelected: (bool value) {
                            // TODO: logica ordinamento
                          },
                          avatar: Icon(Icons.swap_vert, size: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                        FilterChip(
                            label: Text("Ricerca per ISBN"),
                            selected: false,
                            onSelected: (bool value) {
                              // TODO: logica ordinamento
                            },
                            avatar: Icon(Icons.search, size: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                        )
                      ]
                    )
                  ]
                ),
              ),
              FavouriteGrid(user: widget.user),
            ],
          )
      ),
      Container(color: Colors.blue),
      Container(color: Colors.yellow),
      Profile(user: widget.user),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: IndexedStack(
          index: _selectedTabIndex,
          children: _pages
        ),
      ),
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: NavigationBar(
              selectedIndex: _selectedTabIndex,
              onDestinationSelected: (int index) {
                setState(() { // refresh of the interface
                  _selectedTabIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(icon: Icon(Icons.bookmark), label: "Preferiti"),
                NavigationDestination(icon: Icon(Icons.add_circle), label: "Vendi"),
                NavigationDestination(icon: Icon(Icons.email), label: "Inbox"),
                NavigationDestination(icon: Icon(Icons.account_circle), label: "Profilo"),
              ]
          ),
        ),
      ),
    );
  }
}