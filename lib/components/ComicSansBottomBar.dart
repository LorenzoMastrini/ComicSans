import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:comicsans/providers/user_provider.dart';



class ComicSansBottomBar extends StatefulWidget {
  final double iconsSize = 30;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected; // Callback to notify the tap

  const ComicSansBottomBar({
    super.key,
    required this.selectedIndex, // Default to Home
    required this.onDestinationSelected,
  });

  @override
  State<ComicSansBottomBar> createState() => _ComicSansBottomBarState();
}

class _ComicSansBottomBarState extends State<ComicSansBottomBar> {
  final GlobalKey add = GlobalKey();

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userProvider = context.read<UserProvider>();

      if(userProvider.loggedInUser != null) {
        if (!userProvider.hasSeenAddComicShowcasePerUser(
            userProvider.loggedInUser!.id)) {
          ShowCaseWidget.of(context).startShowCase([add]);
          userProvider.setHasSeenAddComicShowcasePerUser(
              userProvider.loggedInUser!.id, true);
        }

        Future.delayed(const Duration(seconds: 4), () {
          if(add.currentContext != null){
            ShowCaseWidget.of(context).completed(add);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
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
        currentIndex: widget.selectedIndex,
        onTap: widget.onDestinationSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            activeIcon: Icon(Icons.home, size: widget.iconsSize),
            icon: Icon(Icons.home_outlined, size: widget.iconsSize, color: Theme.of(context).colorScheme.secondary,),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark, size: widget.iconsSize),
            icon: Icon(Icons.bookmark_border, size: widget.iconsSize, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Showcase(
                key: add,
                description: "Premi qui per vendere un fumetto",
                overlayOpacity: 0,
                disableMovingAnimation: true,
                tooltipBackgroundColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(Icons.add_circle_outline, size: 44, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.inbox, size: widget.iconsSize),
            icon: Icon(Icons.inbox_outlined, size: widget.iconsSize, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, size: widget.iconsSize),
            icon: Icon(Icons.person_outline, size: widget.iconsSize, color: Theme.of(context).colorScheme.secondary),
            label: '',
          ),
        ],
      ),
    );
  }
}