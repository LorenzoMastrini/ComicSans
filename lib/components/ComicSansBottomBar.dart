import 'package:comicsans/screens/ComicSansFavorite.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:comicsans/screens/ComicSansInbox.dart';
import 'package:comicsans/screens/ComicSansProfile.dart';
import 'package:comicsans/screens/ComicSansSell1.dart';
import 'package:flutter/material.dart';



class ComicSansBottomBar extends StatefulWidget {
  @override
  State<ComicSansBottomBar> createState() => _ComicSansBottomBarState();
}

class _ComicSansBottomBarState extends State<ComicSansBottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    ComicSansHome(), // Homepage
    ComicSansFavorite(), // Favorite
    ComicSansSell1(), // Sell a comic
    ComicSansInbox(), // Inbox
    ComicSansProfile() // Profile
  ];

  void _onItemTapped(int index) {
    if (index == 2) { // Screen "ComicSansSell"
      showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true, // Takes the whole height of the screen
          useSafeArea: true,
          builder: (BuildContext context) {
            return ComicSansSell1();
          });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
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