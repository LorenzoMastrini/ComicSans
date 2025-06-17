import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/screens/ComicSansFavorite.dart';

class ComicSansHome extends StatefulWidget {
  final String title;

  const ComicSansHome({super.key, required this.title});

  @override
  State<ComicSansHome> createState() {
    return _ComicSansHomeState();
  }
}



class _ComicSansHomeState extends State<ComicSansHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ComicSansAppBar(),
    );
  }

}



class ComicSansHomeContent {


}