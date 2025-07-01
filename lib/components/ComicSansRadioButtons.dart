import 'package:flutter/material.dart';



class ComicSansRadioButtons extends StatelessWidget {
  final String title;
  final List<String> options;
  final bool inputRequired;
  final TextEditingController? controller; // To control from outside
  final ValueChanged<String?>? onChanged;
  final String? selectedValue;

  // Constructor
  const ComicSansRadioButtons({
    super.key,
    required this.title,
    required this.options,
    this.inputRequired = false,
    this.controller,
    this.onChanged,
    this.selectedValue,
  });


  Widget addAsterisk() {
    return inputRequired
      ? const Text(
        '*',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      )
    : const SizedBox.shrink();
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
                    text: title,
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
          ...options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedValue,
              onChanged: (newValue) {
                if (onChanged != null) {
                  onChanged!(newValue);
                  if (controller != null && newValue != controller!.text) {
                    controller!.text = newValue ?? '';
                  }
                }
              },
            );
          }),
        ]
    );
  }
}