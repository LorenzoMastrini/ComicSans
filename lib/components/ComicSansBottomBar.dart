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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'Preferiti',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_circle, size: 40),
            icon:
              SizedBox(
                width: 35,
                height: 35,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey.shade700, width: 2)
                    ),
                    child: Icon(Icons.add_circle_outline, size: 30)
                  ),
                ),
                ),
            label: 'Vendi',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.inbox),
            icon: Icon(Icons.inbox_outlined),
            label: 'Inbox',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}