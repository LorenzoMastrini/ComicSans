import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class ProductGrid extends StatefulWidget{
  User user;
  ProductGrid({super.key, required this.user});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ComicsProvider>();
    final List<Comic> comicsList = provider.getPurchasableComics(widget.user);

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
            onTap: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return ProductDetail(comic: comicsList[index], user: widget.user);
                }
              ));
              if (result == true){
                setState(() {});
              }
            },
            child: ComicCard(comic: comicsList[index], user: widget.user)
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