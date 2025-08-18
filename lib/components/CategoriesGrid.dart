import 'package:comicsans/Components/CategorySlot.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/category.dart';



class CategoriesGrid extends StatelessWidget{
  final List<Category> categories = [
    Category(name: 'Italiano', icon: Icons.bookmark_border),
    Category(name: 'Americano', icon: Icons.bookmark_border),
    Category(name: 'Giapponese', icon: Icons.bookmark_border),
    Category(name: 'Francese', icon: Icons.bookmark_border),
    Category(name: 'ciao5', icon: Icons.bookmark_border),
    Category(name: 'ciao6', icon: Icons.bookmark_border),
  ];

  CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategorySlot(category: category);
        },
        itemCount: categories.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}