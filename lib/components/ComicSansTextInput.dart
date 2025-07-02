import 'package:flutter/material.dart';

class ComicSansTextInput extends StatefulWidget {
  final String title;
  final String hintText;
  final String labelText;
  final bool inputRequired;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextEditingController? controller; // Controller from outside
  final ValueChanged<String>? onChanged; // To notify changes
  final ValueChanged<String>? onFieldSubmitted; // When user confirms the field
  final FormFieldValidator<String>? validator; // To validate forms

  // Constructor
  const ComicSansTextInput({
    super.key,
    required this.title,
    this.hintText = '',
    this.labelText = '',
    this.inputRequired = false,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onFieldSubmitted,
    this.validator,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _ComicSansTextInputState();
}



class _ComicSansTextInputState extends State<ComicSansTextInput> {
  late final bool _usesExternalController;
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  //String? _errorText; // Validation error

  @override
  void initState() {
    super.initState();
    _usesExternalController = widget.controller != null;
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? ''); // Use the given controller or create one
    _controller.addListener(_handleChange);

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && widget.onFieldSubmitted != null) {
        widget.onFieldSubmitted!(_controller.text);
      }
    });
  }

  // Handle updates (especially controller and initialValue)
  @override
  void didUpdateWidget(ComicSansTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Se il controller è cambiato, rimuovi il listener dal vecchio e aggiungilo al nuovo
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller!.removeListener(_handleChange);
      _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
      _controller.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleChange);
    super.dispose(); // Non dispose del controller, perché viene passato da fuori
  }

  void _handleChange() {
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (widget.inputRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Label
        _buildLabel(),
        const SizedBox(height: 8),

        // Input field
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if(widget.inputRequired && (value == null || value.trim().isEmpty)) {
              return 'Campo obbligatorio';
            }
            return widget.validator?.call(value);
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
        ),
      ]
    );
  }
}