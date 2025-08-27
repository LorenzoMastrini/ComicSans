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

  Widget addAsterisk(BuildContext context) {
    return inputRequired
      ? Text(
        '*',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      )
    : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedValue,
      validator: (value) {
        if (inputRequired && (value == null || value.isEmpty)) {
          return 'Campo obbligatorio';
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  WidgetSpan(child: addAsterisk(context)),
                ]
              ),
            ),
            ...options.map((option) {
              return RadioListTile<String> (
                title: Text(option),
                value: option,
                groupValue: state.value,
                onChanged: (newValue) {
                  state.didChange(newValue);
                  if (onChanged != null) onChanged!(newValue);
                  if (controller != null && newValue != controller!.text) {
                    controller!.text = newValue ?? '';
                  }
                },
              );
            }),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  state.errorText ?? '',
                  style: Theme.of(context).inputDecorationTheme.errorStyle ??
                      TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ]
        );
      }
    );
  }
}