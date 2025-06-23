import 'package:flutter/material.dart';

class ComicSansCheckbox extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  //final Function(String?)? onSelectionChanged;

  // Constructor
  const ComicSansCheckbox({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  State<StatefulWidget> createState() => _ComicSansCheckboxState();
}



class _ComicSansCheckboxState extends State<ComicSansCheckbox> {
  bool? _selectedValue;

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
        GridView.builder(
          itemCount: widget.options.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 4.5,
          ),
          itemBuilder: (context, index) {
            final option = widget.options[index];
            return Align(
              alignment: Alignment.centerLeft,
              child: CheckboxListTile(
                visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  option['title'].toString(),
                  style: const TextStyle(
                    fontSize: 14
                  ),
                ),
                value: option['value'],
                onChanged: (bool? value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading, // Checkbox to the left
              ),
            );
          }
        )
      ]
    );
  }
}