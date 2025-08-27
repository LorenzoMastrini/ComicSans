import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComicSansDropdown extends StatelessWidget {
  final String title;
  final List<String> options;
  final bool isExpanded;
  final TextEditingController? controller; // To control from outside
  final ValueChanged<String?>? onChanged;
  final String? value;

  // Constructor
  const ComicSansDropdown({
    super.key,
    required this.title,
    required this.options,
    this.isExpanded = true,
    this.controller,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String> (
              value: value, // Selection handled by the passed value
              isExpanded: isExpanded,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium?.color,
                fontSize: 16,
              ),
              onChanged: (newValue) {
                if (onChanged != null) {
                  onChanged!(newValue);
                  if (controller != null) {
                    controller!.text = newValue ?? ''; // Synchronize external controller
                  }
                }
              },
              items: options.map<DropdownMenuItem<String>>((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option), // Show the text
                );
              }).toList(),
            ),
          ),
        )
      ]
    );
  }
}