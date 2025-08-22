import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/comics_provider.dart';



class FavouriteGrid extends StatelessWidget{
  final List<Comic>? comics;
  const FavouriteGrid({super.key, this.comics});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatch = context.watch<UserProvider>();
    final comicsProviderWatch = context.watch<ComicsProvider>();

    List<Comic> sortedComic = comics ?? List.from(userProviderWatch.getFavoriteComics());

    if (comicsProviderWatch.sortType == SortType.alphabetical) {
      sortedComic.sort((a, b) => a.title.compareTo(b.title));
    } else if (comicsProviderWatch.sortType == SortType.price) {
      sortedComic.sort((a, b) => a.price.compareTo(b.price));
    }

    if (comicsProviderWatch.sortDirection == SortDirection.descending) {
      sortedComic = sortedComic.reversed.toList();
    }

    return Padding(
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
                  return ProductDetail(comic: sortedComic[index]);
                }
              ));
            },
            child: ComicCard(comic: sortedComic[index]));
        },
        itemCount: sortedComic.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}