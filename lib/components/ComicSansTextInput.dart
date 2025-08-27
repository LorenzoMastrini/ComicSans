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
  final bool passwordField;
  final double height;
  final TextStyle? style;

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
    this.passwordField = false,
    this.height = 60,
    this.style
  });

  @override
  State<StatefulWidget> createState() => _ComicSansTextInputState();
}



class _ComicSansTextInputState extends State<ComicSansTextInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late bool _obscureText = widget.passwordField ? true : false;

  @override
  void initState() {
    super.initState();
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

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  Widget _buildLabel() {
    return Padding(
      padding: EdgeInsetsGeometry.directional(bottom: 2),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: widget.title,
              style: widget.style ?? TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold
              ),
            ),
            if (widget.inputRequired)
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildLabel(),

        // Input field
        SizedBox(
          height: widget.height,
          child: TextFormField(
            obscureText: _obscureText,
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            maxLines: widget.passwordField ? 1 : null, // Automatic growth
            expands: widget.passwordField ? false : true,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              hint: Text(
                widget.hintText,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              labelText: widget.labelText,
              border: const OutlineInputBorder(),
              suffixIcon: widget.passwordField
                ? IconButton( // Show hide password only if it's a password field
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,),
                  onPressed: _toggleVisibility,
                )
                : null, // Otherwise don't show the icon
            ),
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(value); // If the validator is provided, use it
                // Otherwise use the input required validator (default)
              } else if(widget.inputRequired && (value == null || value.trim().isEmpty)) {
                return 'Campo obbligatorio';
              }
              return widget.validator?.call(value);
            },
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
          ),
        ),
      ]
    );
  }
}