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
    /*return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTab(Icons.home_outlined, Icons.home, 'Home', 0),
            _buildTab(Icons.bookmark_border, Icons.bookmark, 'Preferiti', 1),
            _buildMiddleTab(2), // "Vendi"
            _buildTab(Icons.mail_outline, Icons.mail, 'Inbox', 3),
            _buildTab(Icons.person_outline, Icons.person, 'Profilo', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, IconData selectedIcon, String label, int index) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isSelected ? selectedIcon : icon, color: Colors.black),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleTab(int index) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(Icons.add, color: Colors.black),
          ),
          const SizedBox(height: 2),
          Text(
            'Vendi',
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }*/
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