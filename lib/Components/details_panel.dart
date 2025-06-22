import 'package:flutter/material.dart';
import 'package:comicsans/comic.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final Comic comic;
  
  const PanelWidget({
    super.key,
    required this.controller,
    required this.comic,
  });


  String formatAuthors(List<String> authors) {
    return authors.join(", ");
  }

  String formatGenre(List<Genre> gen) {
    return gen.map((g) => g.name).join(", ");
  }

  String formatBoolean(bool boolean) {
    return boolean ? "Sì" : "No";
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label: ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        controller: controller,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          _infoRow("Autori", formatAuthors(comic.authors)),
          _infoRow("Genere", formatGenre(comic.gen)),
          _infoRow("Anno di pubblicazione", comic.publishYear.toString()),
          _infoRow("Lingua", comic.language),
          _infoRow("Editore italiano", comic.italianEditor),
          _infoRow("Editore del paese di origine", comic.originalPublisher),
          _infoRow("Collana", comic.series),
          _infoRow("Variant", formatBoolean(comic.variant)),
          _infoRow("Gradato", formatBoolean(comic.graded)),
          _infoRow("Firmato", formatBoolean(comic.signed)),
          _infoRow("Anno edizione", comic.editionYear.toString()),
          _infoRow("ISBN", comic.isbn.toString()),
        ],
      ),
    );
  }

  /*void togglePanel() {
    if (panelController.isPanelClosed) {
      panelController.open();
    }
    else {
      panelController.close();
    }
  }*/

  /*@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: GestureDetector(
                child: Container(
                  height: 5,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //onTap: togglePanel
              ),
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Autori: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(formatAuthors(comic.authors), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Genere: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(formatGenre(comic.gen), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Anno di pubblicazione: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.publishYear.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Lingua: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.language, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Editore italiano: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.italianEditor, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Editore del paese di origine: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.originalPublisher, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Collana: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.series, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Variant: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(formatBoolean(comic.variant), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Gradato: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(formatBoolean(comic.graded), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Firmato: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(formatBoolean(comic.signed), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Anno edizione: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.editionYear.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ISBN: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(comic.isbn.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                ),
              ],
            ),
          ]
      ),
    );
  }*/
  }
