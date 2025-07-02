import 'package:flutter/material.dart';
import 'package:comicsans/category.dart';

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
        ElevatedButton(
          onPressed: () {
            // Azione del pulsante
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(25),
            backgroundColor: Colors.blue, // colore sfondo
          ),
          child: Icon(widget.category.icon),
        ),
        const SizedBox(height: 10),
        Text(
            widget.category.name,
            style: const TextStyle(fontWeight: FontWeight.w500)
        ),
      ],
    )
    ;
  }
}
