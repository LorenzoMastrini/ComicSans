import 'dart:io'; // Per File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Se usi image_picker



class ImageUploadSlot extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final File? initialImage;
  final ValueChanged<File?> onImageSelected; // Callback quando un'immagine viene selezionata/rimossa

  // Constructor
  const ImageUploadSlot({
    super.key,
    this.width = 330.0,
    this.height = 330.0,
    this.borderRadius = BorderRadius.zero,
    this.initialImage,
    required this.onImageSelected,
  });

  @override
  State<ImageUploadSlot> createState() => _ImageUploadSlotState();
}



// State
class _ImageUploadSlotState extends State<ImageUploadSlot> {
  final ImagePicker _picker = ImagePicker();
  File? _uploadedImage;

  @override
  void initState() {
    super.initState();
    _uploadedImage = widget.initialImage;
  }

  @override
  void didUpdateWidget(covariant ImageUploadSlot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialImage?.path != oldWidget.initialImage?.path) {
      setState(() {
        _uploadedImage = widget.initialImage;
      });
    }
  }

  // Select an image from the device gallery or from camera
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _uploadedImage = File(image.path);
      });
      widget.onImageSelected(_uploadedImage);
    }
  }

  // Function to remove the selected image
  void _removeImage() {
    setState(() {
      _uploadedImage = null;
      widget.onImageSelected(null);
    });
  }


  @override
  Widget build(BuildContext context) {
    final plusIconSize = widget.height * 0.1;
    final deleteIconSize = widget.height * 0.07;

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[300], // Background color of the slot
          border: Border.all(
            color: Colors.grey[400]!,
            width: 1.5,
          ),
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Mostra l'immagine se presente
            if (_uploadedImage != null)
              ClipRRect( // To apply borderRadius to the image also
                borderRadius: widget.borderRadius, // Leggermente meno del bordo del container
                child: Image.file(
                  _uploadedImage!, // Image is loaded (!= null)
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover, // Cover the area maintaining the aspect ratio
                ),
              ),

            // Show "+" icon if no image is selected
            if (_uploadedImage == null)
              Icon(
                Icons.add,
                size: plusIconSize, // Dimension of the "+" icon
                color: Colors.grey[600],
              )
            else // If an image is loaded, show the "delete" icon to remove it
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: _removeImage, // Tap to remove the image
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      size: deleteIconSize,
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