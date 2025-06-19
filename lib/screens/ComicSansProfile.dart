import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';

class ComicSansProfile extends StatelessWidget {
  const ComicSansProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ComicSansAppBar(
        title: "Profilo",
        showBackButton: false,
      ),
    );
  }
}