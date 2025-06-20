import 'package:flutter/material.dart';

class ComicSansRadioButtons extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  //final Function(String?)? onSelectionChanged;

  // Constructor
  const ComicSansRadioButtons({
    super.key,
    required this.title,
    required this.options
  });

  @override
  State<StatefulWidget> createState() => _ComicSansRadioButtonsState();
}



class _ComicSansRadioButtonsState extends State<ComicSansRadioButtons> {
  String? _selectedValue;

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
        ...widget.options.map((option) {
          return RadioListTile<String>(
            title: Text(option['title']),
            value: option['value'],
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            }
          );
        })
      ]
    );
  }
}