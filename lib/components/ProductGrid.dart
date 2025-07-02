import 'package:flutter/material.dart';
import 'package:comicsans/SampleData.dart';
import 'package:comicsans/Components/ComicCard.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import '../user.dart';

class ProductGrid extends StatefulWidget{
  User user;
  ProductGrid({super.key, required this.user});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context){
    final comicsNotSelledByUser = SampleData.allComics.where((comic) => comic.seller.id != widget.user.id).toList();

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
                          return ProductDetail(comic: comicsNotSelledByUser[index], user: widget.user);
                        }
                    )
                  );
                  if (result == true){
                    setState(() {

                    }
                  );
                  }
                },
                child: ComicCard(comic: comicsNotSelledByUser[index], user: widget.user)
              );
            },
            itemCount: comicsNotSelledByUser.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
        ),
      );

  }
}