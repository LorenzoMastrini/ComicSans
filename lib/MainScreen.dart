import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/sample_data.dart';
import 'package:comicsans/screens/ComicSansFavorite.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:comicsans/screens/ComicSansInbox.dart';
import 'package:comicsans/screens/ComicSansProfile.dart';
import 'package:comicsans/screens/ComicSansSell1.dart'; // Page for the modal
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
  int _navigationBarIndex = 0; //(0: Home, 1: Favorite, 2: Sell, 3: Inbox, 4: Profile)

  static List<Widget> _pageContents = <Widget>[
    ComicSansHome(user: SampleData.allUsers[0], purchaseConfirmed: false),
    ComicSansFavorite(user: SampleData.allUsers[0]),
    // No page fo Sell1 because it opens a modal
    ComicSansInbox(),
    ComicSansProfile(user: SampleData.allUsers[0]),
  ];

  void _onBottomNavItemTapped(int navBarIndex) {
    if (navBarIndex == 2) { // Item "Sell"
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext modalContext) {
          return const ComicSansSell1();
        },
      );
      // Don't update _navigationBarIndex cause modal is temporary and last page must remain active
    } else {
      setState(() {
        _navigationBarIndex = navBarIndex;
      });
    }
  }

  // Handle the offset of the index
  String _getTitleForActualPage(int actualPageIndex) {
    if (actualPageIndex == 0) return '';
    if (actualPageIndex == 1) return 'Preferiti';
    // actualPageIndex per _pageContents non sarà mai l'equivalente di 'Sell'
    if (actualPageIndex == 2) return 'Inbox'; // Correspond to _pageContents[2]
    if (actualPageIndex == 3) return 'Profilo'; // Correspond to _pageContents[3]
    return '';
  }

    @override
    Widget build(BuildContext context) {
      // Mappa l'indice della NavigationBar (_navigationBarIndex)
      // all'indice corretto per l'IndexedStack (_actualPageIndex)
      // Questo è necessario perché l'item "Sell" (indice 2) non ha una pagina
      // corrispondente in _pageContents.
      int actualPageIndex;
      if (_navigationBarIndex < 2) { // Home (0), Favorite (1)
        actualPageIndex = _navigationBarIndex;
      } else if (_navigationBarIndex > 2) { // Inbox (NavBar 3 -> Stack 2), Profile (NavBar 4 -> Stack 3)
        actualPageIndex = _navigationBarIndex - 1;
      } else { // _navigationBarIndex è 2 (Sell)
        // Il modal si è aperto (o si sta aprendo).
        // Dobbiamo decidere quale pagina dell'IndexedStack rimane visibile sotto.
        // Idealmente, l'ultima pagina attiva.
        // Poiché _onBottomNavItemTapped NON fa setState per navBarIndex == 2,
        // _navigationBarIndex mantiene il suo valore precedente,
        // e quindi actualPageIndex sarà calcolato correttamente da quel valore.
        // Questa clausola 'else' qui è più una sicurezza o per uno stato iniziale.
        // Se _navigationBarIndex fosse *inizializzato* a 2 (non dovrebbe),
        // dovremmo mostrare una pagina di default.
        actualPageIndex = 0; // Default alla prima pagina (Home)
      }

      return Scaffold(
        body: IndexedStack(
          index: actualPageIndex, // Use the mapped index
          children: _pageContents,
        ),
        bottomNavigationBar: ComicSansBottomBar(
          selectedIndex: _navigationBarIndex, // The index of the NavigationBar remains direct
          onDestinationSelected: _onBottomNavItemTapped,
        ),
      );
    }
}