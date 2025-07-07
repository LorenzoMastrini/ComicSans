import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansSearchBar.dart';
import 'package:comicsans/components/ProductsGrid.dart';
import 'package:comicsans/global_constants.dart';
import 'package:flutter/material.dart';



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
                    child: ComicSansSearchBar(searchContent: SearchContent.favoriteComics)
                  ),
                  SizedBox(width: 10),
                  SizedBox(
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
            ProductsGrid(gridContent: GridContent.favoriteComics),
          ],
        )
      ),
    );
  }
}