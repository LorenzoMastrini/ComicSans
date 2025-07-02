import 'package:flutter/material.dart';



class ComicSansBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected; // Callback to notify the tap

  const ComicSansBottomBar({
    super.key,
    required this.selectedIndex, // Default to Home
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_outline),
          label: 'Favorite',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.add_circle),
          icon: Icon(Icons.add_circle_outline),
          label: 'Sell',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.inbox),
          icon: Icon(Icons.inbox_outlined),
          label: 'Inbox',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}