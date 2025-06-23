import 'package:flutter/material.dart';

class ComicSansRadioButtons extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  //final Function(String?)? onSelectionChanged;
  final bool inputRequired;

  // Constructor
  const ComicSansRadioButtons({
    super.key,
    required this.title,
    required this.options,
    this.inputRequired = false
  });

  @override
  State<StatefulWidget> createState() => _ComicSansRadioButtonsState();
}



class _ComicSansRadioButtonsState extends State<ComicSansRadioButtons> {
  String? _selectedValue;

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