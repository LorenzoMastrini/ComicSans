import 'package:flutter/material.dart';
import 'package:comicsans/sample_data.dart';
import 'package:comicsans/user.dart';
import 'package:comicsans/screens/results_screen.dart';

import '../comic.dart';

class MySearchBar extends StatefulWidget{
  User user;
  MySearchBar({super.key, required this.user});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
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
              delegate: MySearchDelegate(user: widget.user)
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  User user;

  MySearchDelegate({required this.user});

  @override
  String get searchFieldLabel => 'Ricerca...';

  @override
  List<Widget>? buildActions(BuildContext context) {
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
    List<Comic> matchQuery = [];
    for (var c in SampleData.allComics) {
      if (c.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(c);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      close(context, query);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => SearchResults(
          comicsResults: matchQuery.where((comic) => comic.seller.id != user.id).toList(),
          user: user,
          query: query,
        ),
      ));
    });
    return Container();
  }
/*return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        Comic comics = matchQuery[index];
        return TextButton(
            onPressed: () {
              close(context, null);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return SearchResults(comicsResults: matchQuery, user: user);
                  }
               )
              );
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // <-- rettangolare
              ),
            ),
            child: ListTile(
              title: Text(comics.title),
            ),
        );
      }
    );
  }*/

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Comic> matchQuery = [];
    for(var c in SampleData.allComics){
      if(c.title.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(c);
      }
    }
    List<Comic> filteredComics = matchQuery.where((comic) => comic.seller.id != user.id).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: FilterChip(
              label: Text("Ricerca per ISBN"),
              selected: false,
              onSelected: (bool value) {
                // TODO: logica ordinamento
              },
              avatar: Icon(Icons.search, size: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredComics.length,
            itemBuilder: (context, index){
              Comic comics = filteredComics[index];
              return TextButton(
                onPressed: () {
                  close(context, query);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return SearchResults(comicsResults: [comics], user: user, query: query);
                      }
                  )
                  );
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // <-- rettangolare
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