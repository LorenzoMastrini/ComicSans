import 'package:flutter/material.dart';



class ComicSansBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const ComicSansBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.favorite), label: "Preferiti"),
        NavigationDestination(icon: Icon(Icons.add_circle), label: "Vendi"),
        NavigationDestination(icon: Icon(Icons.email), label: "Inbox"),
        NavigationDestination(icon: Icon(Icons.account_circle), label: "Profilo"),
      ],
    );
  }
}