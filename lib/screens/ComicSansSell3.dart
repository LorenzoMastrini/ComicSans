import 'dart:io';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansCheckbox.dart';
import 'package:comicsans/components/ComicSansDropdown.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/components/ComicSansToggle.dart';
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
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 5; // Space for the ListView to avoid content under the button

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: '3/3: Dettagli',
          showBackButton: true,
          showCloseButton: true,
          actionType: AppBarActionType.close
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

                    // Authors
                    ComicSansTextInput(
                      title: 'Autori',
                      hintText: 'Autori',
                      labelText: 'Sceneggiatore, disegnatore',
                    ),
                    SizedBox(height: 20),

                    // Genre
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
                    SizedBox(height: 20),

                    // Publication year
                    ComicSansTextInput(
                      title: 'Anno di pubblicazione',
                      hintText: 'Anno di pubblicazione',
                      labelText: 'Inserisci la data di pubblicazione dell\'opera',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),

                    ComicSansDropdown(
                        title: 'Lingua',
                        options: [
                          {'id': 'Italiano', 'value': 'italiano'},
                          {'id': 'Inglese', 'value': 'inglese'},
                          {'id': 'Spagnolo', 'value': 'spagnolo'},
                          {'id': 'Tedesco', 'value': 'tedesco'},
                          {'id': 'Francese', 'value': 'francese'},
                          {'id': 'Giapponese', 'value': 'giapponese'},
                          {'id': 'Altro', 'value': 'altro'},
                        ]
                    ),
                    SizedBox(height: 20),

                    // Italian publisher
                    ComicSansTextInput(
                      title: 'Editore italiano',
                      hintText: 'Editore italiano',
                      labelText: 'Inserisci l\'editore italiano del fumetto',
                    ),
                    SizedBox(height: 20),

                    // Original publisher
                    ComicSansTextInput(
                      title: 'Editore paese di origine',
                      hintText: 'Editore paese di origine',
                      labelText: 'Inserisci l\'editore originale del fumetto',
                    ),
                    SizedBox(height: 20),

                    // Collana
                    ComicSansTextInput(
                      title: 'Collana',
                      hintText: 'Collana',
                      labelText: 'Inserisci la collana di appartenenza del fumetto',
                    ),
                    SizedBox(height: 20),

                    // Country of origin
                    ComicSansTextInput(
                      title: 'Paese di origine',
                      hintText: 'Paese di origine',
                      labelText: 'Inserisci il paese di origine del fumetto',
                    ),
                    SizedBox(height: 20),

                    // Variant
                    ComicSansToggle(title: 'Variant'),
                    SizedBox(height: 20),

                    // Bookbinding
                    ComicSansRadioButtons(
                        title: 'Rilegatura',
                        options: [
                          {'title': 'Spillato', 'value': 'spillato'},
                          {'title': 'Cartonato', 'value': 'cartonato'},
                          {'title': 'Brossurato', 'value': 'brossurato'},
                          {'title': 'Altro', 'value': 'altro'},
                        ]
                    ),
                    SizedBox(height: 20),

                    // Graded
                    ComicSansToggle(title: 'Gradato'),
                    SizedBox(height: 20),

                    // Signed
                    ComicSansToggle(title: 'Firmato'),
                    SizedBox(height: 20),

                    // Edition year
                    ComicSansTextInput(
                      title: 'Anno edizione',
                      hintText: 'Anno edizione',
                      labelText: 'Inserisci la data di uscita dell\'edizione',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),

                    // ISBN
                    ComicSansTextInput(
                      title: 'ISBN',
                      hintText: 'ISBN',
                      labelText: 'Inserisci l\'ISBN del volume',
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: bottomSpaceForButton)
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
                      Navigator.pushNamed(context, '/'); // return to the main screen
                    },
                    child: const Text('Pubblica')
                  ),
                )
              ]
            ),
          )
        )
    );
  }
}