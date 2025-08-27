import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';



// Types of grid varies with the page in which it's displayed
enum GridContent { purchasableComics, favoriteComics }

class ProductsGrid extends StatefulWidget {
  final GridContent gridContent;
  final List<Comic>? comics;
  const ProductsGrid({super.key, required this.gridContent, this.comics});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {

  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatch = context.watch<UserProvider>();
    List<Comic>? comicsList = widget.comics; // Grid elements varies based on the page in which it's displayed

    switch (widget.gridContent) {
      case GridContent.purchasableComics:
        comicsList ??= userProviderWatch.getPurchasableComics(context);
        break;
      case GridContent.favoriteComics:
        comicsList ??= userProviderWatch.getFavoriteComics();
        break;
    }

    List<Comic> sortedComic = _sort(context, comicsList);

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: .65,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductDetail(comic: sortedComic![index])
              ));
            },
            child: ShowCaseWidget(builder: (context) => ComicCard(comic: sortedComic![index]))
          );
        },
        itemCount: sortedComic.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }

  List<Comic> _sort(BuildContext context, List<Comic> comicsList) {
    final comicsProviderWatch = context.watch<ComicsProvider>();
    List<Comic> sortedComic = List.from(comicsList);

    if (comicsProviderWatch.sortType == SortType.alphabetical) {
      sortedComic.sort((a, b) => a.title.compareTo(b.title));
    } else if (comicsProviderWatch.sortType == SortType.price) {
      sortedComic.sort((a, b) => a.price.compareTo(b.price));
    }

    if (comicsProviderWatch.sortDirection == SortDirection.descending) {
      sortedComic = sortedComic.reversed.toList();
    }

    return sortedComic;
  }
}