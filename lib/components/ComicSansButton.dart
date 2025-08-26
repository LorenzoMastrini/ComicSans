import 'package:flutter/material.dart';



class ComicSansButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  bool enabled;
  final double height;
  final double width;

  ComicSansButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.height = 60,
    this.width = 318,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: Theme.of(context).colorScheme.tertiary
        ),
      )
    );
  }
}