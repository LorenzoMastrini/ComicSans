import 'dart:io'; // Per File
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Se usi image_picker



class ImageUploadSlot extends StatefulWidget {
  final double width;
  final double height;
  final double plusDimension;
  final BorderRadiusGeometry borderRadius;
  final File? initialImage;
  final ValueChanged<File?> onImageSelected; // Callback quando un'immagine viene selezionata/rimossa

  const ImageUploadSlot({
    super.key,
    this.width = 50.0,
    this.height = 330.0,
    this.plusDimension = 20, // Dimensione predefinita dell'icona "+"
    this.borderRadius = BorderRadius.zero,
    this.initialImage,
    required this.onImageSelected,
  });

  @override
  State<ImageUploadSlot> createState() => _ImageUploadSlotState();
}



class _ImageUploadSlotState extends State<ImageUploadSlot> {
  File? _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.initialImage;
  }

  // Funzione di esempio per selezionare un'immagine
  Future<void> _pickImage() async {
    // Esempio con image_picker (image_picker da aggiungere a pubspec.yaml)
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //
    // if (image != null) {
    //   setState(() {
    //     _currentImage = File(image.path);
    //   });
    //   widget.onImageSelected(_currentImage);
    // }

    // Placeholder: simula la selezione o la rimozione di un'immagine
    if (_currentImage == null) {
      // Simula la selezione di un'immagine fittizia
    } else {
      // Simula la rimozione dell'immagine
      setState(() {
        _currentImage = null;
      });
      widget.onImageSelected(null);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_currentImage == null ? "Immagine rimossa" : "Immagine selezionata")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[300], // Colore di sfondo dello slot
          border: Border.all(
            color: Colors.grey[400]!,
            width: 1.5,
          ),
          borderRadius: widget.borderRadius, // Angoli arrotondati
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Mostra l'immagine se presente
            if (_currentImage != null)
              ClipRRect( // Per applicare borderRadius anche all'immagine
                borderRadius: BorderRadius.circular(7.0), // Leggermente meno del bordo del container
                child: Image.file(
                  _currentImage!,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover, // Copre l'area mantenendo le proporzioni
                ),
              ),

            // Mostra l'icona "+" se nessuna immagine è selezionata
            // o un'icona "elimina" se un'immagine è presente (opzionale)
            if (_currentImage == null)
              Icon(
                Icons.add,
                size: widget.plusDimension, // Dimensione dell'icona "+"
                color: Colors.grey[600],
              )
            else
            // Opzionale: Mostra un'icona per rimuovere l'immagine
            // Potresti volerla posizionare diversamente o mostrarla solo onHover/onLongPress
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () { // Separata onTap per cancellare
                    setState(() {
                      _currentImage = null;
                    });
                    widget.onImageSelected(null);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: widget.width * 0.15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}