import 'package:comicsans/screens/ComicSansFavorite.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:flutter/material.dart';



class ComicSansBottomBar extends StatefulWidget {
  @override
  State<ComicSansBottomBar> createState() => _ComicSansBottomBarState();
}

class _ComicSansBottomBarState extends State<ComicSansBottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    ComicSansHome(title: 'Comic Sans',), // home
    ComicSansFavorite(),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.red),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _selectedIndex,
          children: _pages
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Preferiti"),
          NavigationDestination(icon: Icon(Icons.add_circle), label: "Vendi"),
          NavigationDestination(icon: Icon(Icons.email), label: "Inbox"),
          NavigationDestination(icon: Icon(Icons.account_circle), label: "Profilo"),
        ],
      ),
    );
  }
}