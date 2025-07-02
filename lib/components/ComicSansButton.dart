import 'package:comicsans/comic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicSansButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const ComicSansButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

}