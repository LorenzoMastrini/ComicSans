import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ProductsGrid.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansSearchBarFavourite.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/components/ComicSansToggle.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/components/FavouriteGrid.dart';
import 'FiltersFavouriteScreen.dart';
import 'IsbnFavouriteSearchScreen.dart';



class ComicSansFavorite extends StatefulWidget {
  const ComicSansFavorite({super.key});

  @override
  State<ComicSansFavorite> createState() => _ComicSansFavoriteState();
}

class _ComicSansFavoriteState extends State<ComicSansFavorite> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ComicsProvider>();
    final providerRead = context.read<ComicsProvider>();
    final userProviderWatch = context.watch<UserProvider>();

    final List<Comic> results = query.isEmpty
        ? userProviderWatch.getFavoriteComics()
        : userProviderWatch.getFavoriteComics().where((comic) => comic.title.toLowerCase().contains(query.toLowerCase())).toList();

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ComicSansToggle(
                title: 'Prezzo',
                value: providerWatch.sortType == SortType.price,
                onChanged: (value) {
                  providerRead.sortType = value ? SortType.price : SortType.none;
                }
              ),
              ComicSansToggle(
                title: 'Ordine alfabetico',
                value: providerWatch.sortType == SortType.alphabetical,
                onChanged: (value) {
                  providerRead.sortType = value ? SortType.alphabetical : SortType.none;
                }
              ),
              const Divider(),
              RadioListTile<SortDirection>(
                title: const Text("Crescente"),
                value: SortDirection.ascending,
                groupValue: providerWatch.sortDirection,
                onChanged: (value) {
                  providerRead.sortDirection = value!;
                },
              ),
              RadioListTile<SortDirection>(
                title: const Text("Decrescente"),
                value: SortDirection.descending,
                groupValue: providerWatch.sortDirection,
                onChanged: (value) {
                  providerRead.sortDirection = value!;
                },
              ),
            ],
          ),
        )
      ),
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
                    child: ComicSansSearchBarFavourite(
                      onQueryChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    )
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
                              return FiltersFavouriteScreen(query: query);
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
                      Builder(
                        builder: (context) => FilterChip(
                          label: Text(
                            "Ordina per",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12,
                            )
                          ),
                          selected: false,
                          onSelected: (bool value) {
                            Scaffold.of(context).openDrawer();
                          },
                          avatar: Icon(Icons.swap_vert, size: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ),
                      FilterChip(
                        label: Text(
                          "Ricerca per ISBN",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                          )
                        ),
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
            results.isEmpty
              ? Text("Nessun fumetto trovato", style: TextStyle(fontSize: 14))
              : FavouriteGrid(comics: results),
          ],
        )
      ),
    );
  }
}