import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:provider/provider.dart';



// Types of grid varies with the page in which it's displayed
enum GridContent { purchasableComics, favoriteComics }

class ProductsGrid extends StatelessWidget {
  final GridContent gridContent;

  const ProductsGrid({super.key, required this.gridContent});

  @override
  Widget build(BuildContext context) {
    final userProviderWatch = context.watch<UserProvider>();
    final List<Comic> comicsList; // Grid elements varies based on the page in which it's displayed

    switch (gridContent) {
      case GridContent.purchasableComics:
        comicsList = userProviderWatch.getPurchasableComics();
        break;
      case GridContent.favoriteComics:
        comicsList = userProviderWatch.getFavoriteComics();
        break;
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
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProductDetail(comic: comicsList[index])
                ));
              },
              child: ComicCard(comic: comicsList[index])
          );
        },
        itemCount: comicsList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}