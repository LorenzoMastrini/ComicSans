import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/FavouriteGrid.dart';
import 'package:comicsans/components/ComicSansSearchBarFavourite.dart';

import 'FiltersScreen.dart';
import 'FitlersFavouriteScreen.dart';
import 'IsbnFavouriteSearchScreen.dart';
import 'IsbnSearchScreen.dart';



class ComicSansFavorite extends StatelessWidget {
  const ComicSansFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComicSansAppBar(
        showBackButton: false,
        backgroundColor: Colors.transparent,
        title: "Preferiti"
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: MySearchBarFavourite()
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child:
                    IconButton(
                      icon: const Icon(Icons.filter_list, size: 30),
                      tooltip: 'Filtri',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return FiltersFavouriteScreen(query: "");
                            }
                        ));
                      },
                    ),
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => IsbnFavouriteSearchScreen(),
                          ));
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
            FavouriteGrid(),
          ],
        )
      ),
    );
  }
}