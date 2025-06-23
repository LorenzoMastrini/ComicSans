import 'package:flutter/material.dart';

class ComicSansTextInput extends StatefulWidget {
  final String title;
  final String hintText;
  final String labelText;
  final bool inputRequired;

  // Constructor
  const ComicSansTextInput({
    super.key,
    required this.title,
    required this.hintText,
    required this.labelText,
    this.inputRequired = false
  });

  @override
  State<StatefulWidget> createState() => _ComicSansTextInputState();
}



class _ComicSansTextInputState extends State<ComicSansTextInput> {

  Widget addAsterisk() {
    if(widget.inputRequired) {
      return const Text(
        '*',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Label
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                  child: addAsterisk()
              ),
            ]
          ),
        ),

        // Input field
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