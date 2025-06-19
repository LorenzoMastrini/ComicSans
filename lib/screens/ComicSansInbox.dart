import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';

class ComicSansInbox extends StatelessWidget {
  const ComicSansInbox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ComicSansAppBar(
        title: "Messaggi",
        showBackButton: false,
        showCloseButton: false,
        actionType: appBarActionType.none,
      ),
    );
  }
}