import 'package:flutter/material.dart';

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
    Container(color: Colors.orange),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: IndexedStack(
        index: _selectedTabIndex,
        children: _pages
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedTabIndex,
          onDestinationSelected: (int index) {
            setState(() { // refresh of the interface
              _selectedTabIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.favorite), label: "Preferiti"),
            NavigationDestination(icon: Icon(Icons.add_circle), label: "Vendi"),
            NavigationDestination(icon: Icon(Icons.email), label: "Inbox"),
            NavigationDestination(icon: Icon(Icons.account_circle), label: "Profilo"),
          ]
      ),
    );
  }

}