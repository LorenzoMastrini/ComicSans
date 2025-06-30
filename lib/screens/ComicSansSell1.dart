import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
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
    const double btnBottomPadding = 15; // Bottom padding for the button
    const double btnHeight = 60;
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 5;

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: "1/3: Informazioni base",
          showBackButton: false,
          showCloseButton: true,
          actionType: appBarActionType.close
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Informazione obbligatoria'
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Titolo
                  const ComicSansTextInput(
                    title: 'Titolo',
                    hintText: 'Titolo',
                    labelText: 'Inserisci il titolo del fumetto',
                    inputRequired: true
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const ComicSansTextInput(
                    title: 'Descrizione',
                    hintText: 'Descrizione',
                    labelText: 'Inserisci la descrizione del fumetto',
                    inputRequired: true
                  ),
                  const SizedBox(height: 20),

                  // Price
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ComicSansTextInput(
                          title: 'Prezzo',
                          hintText: 'Prezzo',
                          labelText: 'Inserisci un prezzo appropriato',
                          inputRequired: true
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 10),
                        child: Text(
                          '€',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 20),

                  // Conditions
                  const ComicSansRadioButtons(
                    title: 'Condizioni',
                    options: [
                      {'title': 'Da edicola', 'value': 'Da edicola'},
                      {'title': 'Ottime', 'value': 'Ottime'},
                      {'title': 'Buone', 'value': 'Buone'},
                      {'title': 'Molto usato', 'value': 'Molto usato'}
                    ],
                    inputRequired: true
                  ),

                  const SizedBox(height: bottomSpaceForButton),
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