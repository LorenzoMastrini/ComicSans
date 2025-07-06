import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:provider/provider.dart';



class FavouriteGrid extends StatefulWidget{
  User user;
  FavouriteGrid({super.key, required this.user});

  @override
  State<FavouriteGrid> createState() => _FavouriteGridState();
}

class _FavouriteGridState extends State<FavouriteGrid> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ComicsProvider>();

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
                  return ProductDetail(comic: provider.favorite[index], user: widget.user);
                }
              ));
            },
            child: ComicCard(comic: provider.favorite[index], user: widget.user));
        },
        itemCount: provider.favorite.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}