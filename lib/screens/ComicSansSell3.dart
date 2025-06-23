import 'dart:io';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansCheckbox.dart';
import 'package:comicsans/components/ComicSansInputForm.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/components/ImageUploadSlot.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:flutter/material.dart';

class ComicSansSell3 extends StatefulWidget {
  const ComicSansSell3({super.key});

  @override
  State<ComicSansSell3> createState() => _ComicSansSell3State();
}



class _ComicSansSell3State extends State<ComicSansSell3> {

  @override
  Widget build(BuildContext context) {
    const double btnBottomPadding = 15; // Bottom padding for the button
    const double btnHeight = 60;
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 2; // Space for the ListView to avoid content under the button

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: '3/3: Dettagli',
          showBackButton: true,
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
                  children: const [
                    Text('Le seguenti informazioni non sono obbligatorie'),
                    SizedBox(height: 20),

                    // Autori
                    ComicSansTextInput(
                      title: 'Autori',
                      hintText: 'Autori',
                      labelText: 'Sceneggiatore, disegnatore',
                    ),

                    // Description
                    ComicSansTextInput(
                      title: 'Descrizione',
                      hintText: 'Descrizione',
                      labelText: 'Inserisci la descrizione del fumetto',
                    ),

                    // Genere
                    ComicSansCheckbox(
                      title: 'Genere',
                      options: [
                        {'title': 'Avventura', 'value': false},
                        {'title': 'Azione', 'value': false},
                        {'title': 'Crime', 'value': false},
                        {'title': 'Drammatico', 'value': false},
                        {'title': 'Fantasy', 'value': false},
                        {'title': 'Horror', 'value': false},
                        {'title': 'Poliziesco', 'value': false},
                        {'title': 'Romantico', 'value': false},
                        {'title': 'Sci-Fi', 'value': false},
                        {'title': 'Soprannaturale', 'value': false},
                        {'title': 'Supereroi', 'value': false},
                        {'title': 'Thriller', 'value': false},
                        {'title': 'Umoristico', 'value': false},
                        {'title': 'Altro', 'value': false},

                      ],
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
                              builder: (context) => ComicSansHome()
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