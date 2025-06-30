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
  // local state list, initialized from widget.options
  late List<Map<String, dynamic>> _currentOptions;

  @override
  void initState() {
    super.initState();
    // Initialize _currentOptions as editable copy of widget.options
    _currentOptions = widget.options.map((optionFromWidget) {
      final Map<String, dynamic> newOption = Map<String, dynamic>.from(optionFromWidget);
      // Ensure 'value' to be bool
      if (newOption['value'] == null || newOption['value'] is! bool) {
        newOption['value'] = false; // Default value
      }
      return newOption;
    }).toList();
  }

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
            return Align(
              alignment: Alignment.centerLeft,
              child: CheckboxListTile(
                visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-10, 0),
                  child: Text(
                    _currentOptions[index]['title'].toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                value: _currentOptions[index]['value'] as bool?,
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _currentOptions[index]['value'] = newValue;
                    });
                  }
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