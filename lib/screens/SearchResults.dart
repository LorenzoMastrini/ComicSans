import 'package:comicsans/components/ComicSansSearchBar.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/comic.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import '../Components/ComicSansAppBar.dart';
import '../components/ComicSansToggle.dart';
import '../providers/comics_provider.dart';
import 'FiltersScreen.dart';
import 'IsbnSearchScreen.dart';



class SearchResults extends StatelessWidget {
  final List<Comic> comicsResults;
  final String query;
  const SearchResults({super.key, required this.comicsResults, required this.query});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ComicsProvider>();
    final providerRead = context.read<ComicsProvider>();

    List<Comic> sortedResults = List.from(comicsResults);

    if (providerWatch.sortType == SortType.alphabetical) {
      sortedResults.sort((a, b) => a.title.compareTo(b.title));
    } else if (providerWatch.sortType == SortType.price) {
      sortedResults.sort((a, b) => a.price.compareTo(b.price));
    }

    if (providerWatch.sortDirection == SortDirection.descending) {
      sortedResults = sortedResults.reversed.toList();
    }

    if (comicsResults.isEmpty) {
      return Scaffold(
        appBar: ComicSansAppBar(showBackButton: true, title: "Risultati"),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ComicSansSearchBar()
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.filter_list, size: 30),
                    tooltip: 'Filtri',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return FiltersScreen(query: query);
                          }
                      ));
                    },
                  ),
                ]
              ),
            ),
            Center(child: Text("Nessun fumetto trovato.")),
          ]
        )
      );
    }
    return Scaffold(
      appBar: ComicSansAppBar(showBackButton: true, title: "Risultati"),
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
      body: SingleChildScrollView(
        child: Column(
          children:<Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ComicSansSearchBar()
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.filter_list, size: 30),
                    tooltip: 'Filtri',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FiltersScreen(query: query)
                      ));
                    },
                  ),
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
                          onSelected: (bool value) => Scaffold.of(context).openDrawer(),
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
                            builder: (context) => IsbnSearchScreen(),
                          ));
                        },
                        avatar: Icon(Icons.search, size: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      )
                    ]
                  )
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: .65,
                ),
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductDetail(comic: sortedResults[index])
                      ));
                    },
                    child: ShowCaseWidget(builder: (context) => ComicCard(comic: sortedResults[index]))
                  );
                },
                itemCount: comicsResults.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
              ),
            ),
          ]
        ),
      ),
    );
  }
}