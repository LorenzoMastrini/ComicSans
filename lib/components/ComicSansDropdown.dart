import 'package:flutter/material.dart';

class ComicSansDropdown extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  //final Function(String?)? onSelectionChanged;
  final bool isExpanded;
  final String valueKey;
  final String displayKey;

  // Constructor
  const ComicSansDropdown({
    super.key,
    required this.title,
    required this.options,
    this.isExpanded = true,
    this.valueKey = 'id',       // Valore di default per la chiave del valore
    this.displayKey = 'value',
  });

  @override
  State<StatefulWidget> createState() => _ComicSansDropdownState();
}



class _ComicSansDropdownState extends State<ComicSansDropdown> {
  Map<String, dynamic>? _selectedValue;

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Map<String, dynamic>>(
                value: _selectedValue, // DEVE ESSERE L'ISTANZA DALLA LISTA
                isExpanded: widget.isExpanded,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleMedium?.color,
                  fontSize: 16,
                ),
                onChanged: (Map<String, dynamic>? newValue) {
                  setState(() {
                    _selectedValue = newValue; // newValue è già l'istanza corretta dalla lista items
                  });
                },
                items: widget.options.map<DropdownMenuItem<Map<String, dynamic>>>((Map<String, dynamic> optionMap) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: optionMap, // L'intera mappa è il valore
                    child: Text(optionMap[widget.displayKey]?.toString() ?? 'N/D'), // Mostra il testo usando displayKey
                  );
                }).toList(),
              ),
            ),
          )
        ]
    );
  }
}