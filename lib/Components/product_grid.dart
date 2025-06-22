import 'package:flutter/material.dart';
import 'package:comicsans/sample_data.dart';
import 'package:comicsans/Components/comic_card.dart';
import 'package:comicsans/screens/product_details.dart';

class ProductGrid extends StatefulWidget{
  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
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
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return ProductDetail(comic: SampleData.allComics[index]);
                        }
                    )
                  );
                },
                child: ComicCard(comic: SampleData.allComics[index]));
            },
            itemCount: SampleData.allComics.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
        ),
      );

  }
}