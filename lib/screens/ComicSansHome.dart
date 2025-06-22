import 'package:comicsans/Components/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/categories_grid.dart';
import 'package:comicsans/Components/search_bar.dart' hide SearchBar;


class ComicSansHome extends StatefulWidget {
  final String title;

  const ComicSansHome({super.key, required this.title});

  @override
  State<ComicSansHome> createState() {
    return _ComicSansHomeState();
  }
}

class _ComicSansHomeState extends State<ComicSansHome> {
  int _selectedTabIndex = 0;

  final List<Widget> _pages = <Widget>[
    SingleChildScrollView(
      child: Column(
        children: <Widget>[
            MySearchBar(),
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
            ProductGrid()
          ],
        ),
    ),
      Container(color: Colors.green),
      Container(color: Colors.blue),
      Container(color: Colors.yellow),
      Container(color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
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