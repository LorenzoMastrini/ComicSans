import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/screens/ComicSansFavorite.dart';
import 'package:comicsans/screens/ComicSansInbox.dart';
import 'package:comicsans/screens/ComicSansProfile.dart';
import 'package:flutter/material.dart';

class ComicSansHome extends StatefulWidget {
  const ComicSansHome({super.key});

  @override
  State<ComicSansHome> createState() {
    return _ComicSansHomeState();
  }
}



class _ComicSansHomeState extends State<ComicSansHome> {
  // Pagine da mostrare nell'IndexedStack (esclude "Sell" che è un modal)
  static final List<Widget> _pageContents = <Widget>[
    const ComicSansHome(),
    const ComicSansFavorite(),
    // L'indice 2 (Sell) è un modal, quindi non ha un corpo qui
    const ComicSansInbox(),
    const ComicSansProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    );
  }
}