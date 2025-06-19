import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansInput.dart';
import 'package:flutter/material.dart';

class ComicSansSell extends StatefulWidget {
  const ComicSansSell({super.key});

  @override
  State<ComicSansSell> createState() => _ComicSansSellState();
}



class _ComicSansSellState extends State<ComicSansSell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ComicSansAppBar(
          title: "1/3: Informazioni base",
          showBackButton: false,
          showCloseButton: true,
          actionType: appBarActionType.close
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: const <Widget>[
              // Title
              ComicSansInput(
                title: 'Titolo',
                hintText: 'Titolo',
                labelText: 'Inserisci il titolo del fumetto'
              ),

              // Description
              ComicSansInput(
                title: 'Descrizione',
                hintText: 'Descrizione',
                labelText: 'Inserisci la descrizione del fumetto'
              ),

              // Price
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ComicSansInput(
                      title: 'Prezzo',
                      hintText: 'Prezzo',
                      labelText: 'Inserisci un prezzo appropriato'
                    ),
                  ),
                  Text(
                    '€',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]
              ),
            ]
          ),
        )
      )
    );
  }
}