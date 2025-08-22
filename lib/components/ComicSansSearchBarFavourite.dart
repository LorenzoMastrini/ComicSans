import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/screens/SearchResults.dart';
import 'package:provider/provider.dart';
import '../screens/FiltersScreen.dart';
import '../screens/IsbnSearchScreen.dart';



class ComicSansSearchBarFavourite extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;
  const ComicSansSearchBarFavourite({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      child: SearchBar(
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 10)
        ),
        leading: const Icon(Icons.search),
        hintText: 'Ricerca...',
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        onChanged: onQueryChanged,
      ),
    );
  }
}
