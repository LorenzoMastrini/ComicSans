import 'package:flutter/material.dart';



typedef OnCheckboxChanged = void Function(String optionTitle, bool newValue);

class ComicSansCheckbox extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  final OnCheckboxChanged? onChanged;

  // Constructor
  const ComicSansCheckbox({
    super.key,
    required this.title,
    required this.options,
    this.onChanged,
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
        GridView.builder(
          itemCount: options.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 4.5,
          ),
          itemBuilder: (context, index) {
            final option = options[index];
            final optionTitle = option['title'].toString();
            final optionValue = option['value'] as bool;

            return Align(
              alignment: Alignment.centerLeft,
              child: CheckboxListTile(
                visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Text(
                    optionTitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                value: optionValue,
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    onChanged?.call(optionTitle, newValue);
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