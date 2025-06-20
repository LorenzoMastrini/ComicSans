import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansInputForm.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:flutter/material.dart';

class ComicSansSell2 extends StatefulWidget {
  const ComicSansSell2({super.key});

  @override
  State<ComicSansSell2> createState() => _ComicSansSell2State();
}



class _ComicSansSell2State extends State<ComicSansSell2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ComicSansAppBar(
          title: "2/3: Carica le foto",
          showBackButton: true,
          showCloseButton: true,
          actionType: appBarActionType.close
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: <Widget>[
              // Title
              ComicSansTextInput(
                title: 'Titolo',
                hintText: 'Titolo',
                labelText: 'Inserisci il titolo del fumetto'
              ),

              // Description
              ComicSansTextInput(
                title: 'Descrizione',
                hintText: 'Descrizione',
                labelText: 'Inserisci la descrizione del fumetto'
              ),

              // Price
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ComicSansTextInput(
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

              // Conditions
              ComicSansRadioButtons(
                title: 'Condizioni',
                options: [
                  {'title': 'Da edicola', 'value': 'Da edicola'},
                  {'title': 'Ottime', 'value': 'Ottime'},
                  {'title': 'Buone', 'value': 'Buone'},
                  {'title': 'Molto usato', 'value': 'Molto usato'}
                ]
              ),

              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Continua'))
            ]
          ),
        )
      )
    );
  }
}