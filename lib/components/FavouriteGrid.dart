import 'package:flutter/material.dart';
import 'package:comicsans/SampleData.dart';
import 'package:comicsans/Components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import '../../user.dart';

class FavouriteGrid extends StatefulWidget{
  User user;
  FavouriteGrid({super.key, required this.user});

  @override
  State<FavouriteGrid> createState() => _FavouriteGridState();
}

class _FavouriteGridState extends State<FavouriteGrid> {
  @override
  Widget build(BuildContext context){
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
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return ProductDetail(comic: widget.user.getFavourites()[index], user: widget.user);
                    }
                  )
                );
                if (result == true){
                    setState(() {
                    }
                  );
                }
              },
              child: ComicCard(comic: widget.user.getFavourites()[index], user: widget.user));
        },
        itemCount: widget.user.favouriteComics.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}