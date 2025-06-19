import 'package:flutter/material.dart';

class ComicSansInput extends StatefulWidget {
  final String title;
  final String hintText;
  final String labelText;

  // Constructor
  const ComicSansInput({
    super.key,
    required this.title,
    required this.hintText,
    required this.labelText
  });

  @override
  State<StatefulWidget> createState() => _ComicSansInputState();
}



class _ComicSansInputState extends State<ComicSansInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.labelText,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20)
      ]
    );
  }
}