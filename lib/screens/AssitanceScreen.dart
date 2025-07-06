import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';

class Assistance extends StatefulWidget {
  @override
  State<Assistance> createState() => _AssistanceState();
}

class _AssistanceState extends State<Assistance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComicSansAppBar(
        title: "Assistenza",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text("Serve aiuto? Contattaci: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
            GestureDetector(
              child: Text("comicsans@gmail.com",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline)),
            ),
          ]
        ),
      )
    );
  }
}