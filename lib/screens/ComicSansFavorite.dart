import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:flutter/material.dart';
import '../Components/FavouriteGrid.dart';
import '../Components/ComicSansSearchBarFavourite.dart';
import '../user.dart';

class ComicSansFavorite extends StatefulWidget {
  static const int _pageIndex = 1;
  User user;
  ComicSansFavorite({super.key, required this.user});

  @override
  State<ComicSansFavorite> createState() => _ComicSansFavoriteState();
}

class _ComicSansFavoriteState extends State<ComicSansFavorite> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ComicSansAppBar(title: "Preferiti", showBackButton: false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: MySearchBarFavourite(user: widget.user)
                    ),
                    SizedBox(width: 10),
                    Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.filter_list, color: Colors.black, size: 30)
                    )
                  ]
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  children: <Widget>[
                    Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                          FilterChip(
                              label: Text("Ordina per"),
                              selected: false,
                              onSelected: (bool value) {
                                // TODO: logica ordinamento
                              },
                              avatar: Icon(Icons.swap_vert, size: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          ),
                          FilterChip(
                              label: Text("Ricerca per ISBN"),
                              selected: false,
                              onSelected: (bool value) {
                                // TODO: logica ordinamento
                              },
                              avatar: Icon(Icons.search, size: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          )
                        ]
                    )
                  ]
              ),
            ),
            FavouriteGrid(user: widget.user),
          ],
        )
    );
  }
}