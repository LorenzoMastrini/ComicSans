import 'package:flutter/material.dart';



class ComicSansAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ComicSansAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
              "assets/logo.png",
              fit: BoxFit.cover,
              height: 35
          ),
          const Text("Comic Sans"),
        ],
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}