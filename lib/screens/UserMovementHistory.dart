import 'package:comicsans/comic.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



enum MovementType { sales, purchases }

class UserMovementHistory extends StatelessWidget {
  final MovementType movementType;

  const UserMovementHistory({super.key, required this.movementType});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatch = context.watch<UserProvider>(); // Provider
    final List<Comic> comicsList; // Elements varies based on the page (sales or purchases)

    switch (movementType) {
      case MovementType.sales:
        comicsList = userProviderWatch.getSales();
        break;
      case MovementType.purchases:
        comicsList = userProviderWatch.getPurchases();
        break;
    }

    return Scaffold(
      appBar: ComicSansAppBar(showBackButton: true, title: "Vendite"),
      body: Padding(
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
                    builder: (context) => ProductDetail(comic: comicsList[index])
                ));
              },
              child: ComicCard(comic: comicsList[index], showFavoriteButton: false)
            );
          },
          itemCount: comicsList.length,
          shrinkWrap: false,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}