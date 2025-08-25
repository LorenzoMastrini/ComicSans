import 'package:flutter/material.dart';



class ComicSansBottomBar extends StatelessWidget {
  final double iconsSize = 30;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected; // Callback to notify the tap

  const ComicSansBottomBar({
    super.key,
    required this.selectedIndex, // Default to Home
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: -8,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 50,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        currentIndex: selectedIndex,
        onTap: onDestinationSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            activeIcon: Icon(Icons.home, size: iconsSize),
            icon: Icon(Icons.home_outlined, size: iconsSize, color: Theme.of(context).colorScheme.secondary,),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark, size: iconsSize),
            icon: Icon(Icons.bookmark_border, size: iconsSize, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_circle, size: 40),
            icon: Icon(Icons.add_circle_outline, size: 40, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.inbox, size: iconsSize),
            icon: Icon(Icons.inbox_outlined, size: iconsSize, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, size: iconsSize),
            icon: Icon(Icons.person_outline, size: iconsSize, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
        ],
      ),
    );
  }
}