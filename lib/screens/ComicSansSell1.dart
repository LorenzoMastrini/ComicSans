import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansInputForm.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/screens/ComicSansSell2.dart';
import 'package:flutter/material.dart';

class ComicSansSell1 extends StatefulWidget {
  const ComicSansSell1({super.key});

  @override
  State<ComicSansSell1> createState() => _ComicSansSell1State();
}



class _ComicSansSell1State extends State<ComicSansSell1> {
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  bottom: 30
                ),
                children: const [
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
                ]
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                      MaterialPageRoute(
                          builder: (context) => ComicSansSell2()
                      )
                    );
                  },
                  child: const Text('Continua')
                ),
              )
            ]
          ),
        )
      )
    );
  }
}