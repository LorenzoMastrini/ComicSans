import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:flutter/material.dart';

class ComicSansFavorite extends StatelessWidget {
  ComicSansFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: const ComicSansAppBar(),
    );
  }

}