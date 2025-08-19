import 'package:comicsans/Components/CategorySlot.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/category.dart';

class CategoriesGrid extends StatefulWidget{
  final List<Category> categories = [
    Category(name: 'Italiano', icon: AssetImage('assets/categories_icons/italian_icon.jpg')),
    Category(name: 'Americano', icon: AssetImage('assets/categories_icons/american_icon.jpg')),
    Category(name: 'Giapponese', icon: AssetImage('assets/categories_icons/japanese_icon.jpg')),
    Category(name: 'Francese', icon: AssetImage('assets/categories_icons/french_icon.jpg')),
  ];

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 40,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index){
          final category = widget.categories[index];
          return CategorySlot(category: category);
        },
        itemCount: widget.categories.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}