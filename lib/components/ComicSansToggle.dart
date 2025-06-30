import 'package:flutter/material.dart';



class ComicSansToggle extends StatefulWidget {
  final String title;
  final bool initialValue;

  // Constructor
  const ComicSansToggle({
    super.key,
    required this.title,
    this.initialValue = false
  });

  @override
  State<StatefulWidget> createState() => _ComicSansToggleState();
}



class _ComicSansToggleState extends State<ComicSansToggle> {
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SwitchListTile(
        contentPadding: EdgeInsetsGeometry.directional(start: 0, end: 0),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        value: _isActive,
        onChanged: (bool newValue) {
          setState(() {
            _isActive = newValue;
          });
        },
        activeColor: Theme.of(context).colorScheme.primary,
        // secondary: Icon(_isNotificationsEnabled ? Icons.notifications_active : Icons.notifications_off),
      ),
    );
  }
}