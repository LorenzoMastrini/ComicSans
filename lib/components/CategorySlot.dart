import 'package:flutter/material.dart';
import 'package:comicsans/category.dart';

import '../screens/CategoryScreen.dart';

class CategorySlot extends StatefulWidget{
  final Category category;
  const CategorySlot({super.key, required this.category});

  @override
  State<CategorySlot> createState() => _CategorySlotState();
}

class _CategorySlotState extends State<CategorySlot> {
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return CategoryScreen(categoryName: widget.category.name);
                }
            ));
          },
          child: CircleAvatar(
            radius: 40,
            backgroundImage: widget.category.icon,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.category.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500
          )
        ),
      ],
    );
  }
}
