import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/FiltersScreen.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/screens/IsbnSearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/screens/SearchResults.dart';
import 'package:comicsans/comic.dart';
import 'package:provider/provider.dart';



class ComicSansSearchBar extends StatelessWidget{
  const ComicSansSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345,
      child: SearchBar(
        //controller: controller;
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
        onTap:(){
          showSearch(
            context: context,
            delegate: MySearchDelegate()
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Ricerca...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.filter_list),
        tooltip: 'Filtri',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => FiltersScreen(query: query),
          ));
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            close(context, null);
          },
        ),
      ]
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    List<Comic> purchasableComics = userProvider.getPurchasableComics();
    List<Comic> matchQuery = [];
    for (var c in context.watch<ComicsProvider>().allComics) {
      if (c.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(c);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      close(context, query);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => SearchResults(
          comicsResults: purchasableComics.where((comic) => matchQuery.contains(comic)).toList(),
          query: query,
        ),
      ));
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Comic> matchQuery = [];
    for(var c in context.watch<UserProvider>().getPurchasableComics()){
      if(c.title.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(c);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: FilterChip(
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
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index){
              Comic comics = matchQuery[index];
              return TextButton(
                onPressed: () {
                  close(context, query);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchResults(comicsResults: [comics], query: query)
                  ));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Rectangular
                  ),
                ),
                child: ListTile(
                  title: Text(comics.title),
                ),
              );
            }
          ),
        )
      ],
    );
  }
}