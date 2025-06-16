import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';

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
      appBar: const ComicSansAppBar(),
      body: IndexedStack(
        index: _selectedTabIndex,
        children: _pages
      ),
      bottomNavigationBar: ComicSansBottomBar(
          selectedIndex: _selectedTabIndex,
          onDestinationSelected: (int index) {
            setState(() { // refresh of the interface
              _selectedTabIndex = index;
            });
          }
      ),
    );
  }

}