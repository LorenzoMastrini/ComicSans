import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ComicSansFavorite.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:comicsans/screens/ComicSansInbox.dart';
import 'package:comicsans/screens/ComicSansProfile.dart';
import 'package:comicsans/screens/ComicSansSell1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _navigationBarIndex = 0; //(0: Home, 1: Favorite, 2: Sell, 3: Inbox, 4: Profile)
  final GlobalKey<ComicSansProfileState> profileKey = GlobalKey<ComicSansProfileState>();

  void _onBottomNavItemTapped(int navBarIndex) {
    if (navBarIndex == 2) { // Item "Sell"
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext modalContext) {
          return ComicSansSell1();
        },
      );
    } else {
      setState(() {
        _navigationBarIndex = navBarIndex;
      });

      if(navBarIndex == 4){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          profileKey.currentState?.onTabVisible();
        });
      }
    }
  }

    @override
    Widget build(BuildContext context) {
    int actualPageIndex;
    if (_navigationBarIndex < 2) { // Home (0), Favorite (1)
      actualPageIndex = _navigationBarIndex;
    } else if (_navigationBarIndex > 2) { // Inbox (NavBar 3 -> Stack 2), Profile (NavBar 4 -> Stack 3)
      actualPageIndex = _navigationBarIndex - 1;
    } else { // _navigationBarIndex is 2 (Sell)
      actualPageIndex = 0; // Default to first page (Home)
    }

    final List<Widget> pageContents = <Widget>[
      ComicSansHome(),
      ComicSansFavorite(),
      // No page fo Sell1 because it opens a modal
      ComicSansInbox(),
      ComicSansProfile(key: profileKey)
    ];

    return ShowCaseWidget(
      builder: (context) => Scaffold(
          body: IndexedStack(
            index: actualPageIndex, // Use the mapped index
            children: pageContents,
          ),
          bottomNavigationBar:
          ComicSansBottomBar(
            selectedIndex: _navigationBarIndex, // The index of the NavigationBar remains direct
            onDestinationSelected: _onBottomNavItemTapped,
          ),
      ),
    );
  }
}