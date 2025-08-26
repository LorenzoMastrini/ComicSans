import 'package:comicsans/global_constants.dart';
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

  String formatBoolean(bool? boolean) {
    if (boolean == null) return "";
    return boolean ? "Sì" : "No";
  }

  Widget _infoRow(BuildContext context, String label, String? value) {
    if(value.toString().isNotEmpty && value != "null") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$label: ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                value ?? "",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        controller: controller,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: Transform.rotate(
                angle: 270 * 3.1415 / 180,
                child: const Icon(Icons.arrow_back_ios_new_sharp)
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          _infoRow(context, "Autori", formatAuthors(comic.authors)),
          _infoRow(context, "Genere", formatGenre(comic.genre)),
          _infoRow(context, "Anno di pubblicazione", comic.publicationYear.toString()),
          _infoRow(context, "Lingua", comic.language),
          _infoRow(context, "Editore italiano", comic.italianPublisher),
          _infoRow(context, "Editore del paese di origine", comic.originalPublisher),
          _infoRow(context, "Collana", comic.series),
          _infoRow(context, "Variant", formatBoolean(comic.variant)),
          _infoRow(context, "Gradato", formatBoolean(comic.graded)),
          _infoRow(context, "Firmato", formatBoolean(comic.signed)),
          _infoRow(context, "Anno edizione", comic.editionYear.toString()),
          _infoRow(context, "ISBN", comic.isbn.toString()),
        ],
      ),
    );
  }
}
