import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';

class ComicSansFavorite extends StatelessWidget {
  const ComicSansFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ComicSansAppBar(
        title: "Preferiti",
        showBackButton: true,
        showCloseButton: false,
        actionType: appBarActionType.none,
      ),
    );
  }
}