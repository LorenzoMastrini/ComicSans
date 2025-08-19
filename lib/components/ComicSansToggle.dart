import 'package:flutter/material.dart';



class ComicSansToggle extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  // Constructor
  const ComicSansToggle({
    super.key,
    required this.title,
    this.value = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 0),
        title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
        // secondary: Icon(_isNotificationsEnabled ? Icons.notifications_active : Icons.notifications_off),
    );
  }
}