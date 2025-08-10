import 'package:comicsans/components/ComicSansSearchBar.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/comic.dart';

import '../components/ComicSansBottomBar.dart';
import 'FiltersScreen.dart';
import 'IsbnSearchScreen.dart';



class SearchResults extends StatelessWidget {
  final List<Comic> comicsResults;
  final String query;
  const SearchResults({super.key, required this.comicsResults, required this.query});

  @override
  Widget build(BuildContext context) {
    if (comicsResults.isEmpty) {
      return Scaffold(
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
      /*bottomNavigationBar: ComicSansBottomBar(
      ),*/
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
                        builder: (context){
                          return FiltersScreen(query: query);
                        }
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
                            builder: (context) => IsbnSearchScreen(),
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
                        builder: (context){
                          return ProductDetail(comic: comicsResults[index]);
                        }
                      ));
                    },
                    child: ComicCard(comic: comicsResults[index])
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