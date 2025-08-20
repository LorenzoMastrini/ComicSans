import 'dart:io'; // Import "File" class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ImageUploadSlot extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final String? initialImagePath;
  final ValueChanged<String?> onImageSelected; // Callback quando un'immagine viene selezionata/rimossa

  // Constructor
  const ImageUploadSlot({
    super.key,
    this.width = 330.0,
    this.height = 330.0,
    this.borderRadius = BorderRadius.zero,
    this.initialImagePath,
    required this.onImageSelected,
  });

  @override
  State<ImageUploadSlot> createState() => _ImageUploadSlotState();
}



// State
class _ImageUploadSlotState extends State<ImageUploadSlot> {
  final ImagePicker _picker = ImagePicker();
  String? _uploadedImagePath;

  @override
  void initState() {
    super.initState();
    _uploadedImagePath = widget.initialImagePath;
  }

  @override
  void didUpdateWidget(covariant ImageUploadSlot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialImagePath != oldWidget.initialImagePath) {
      setState(() {
        _uploadedImagePath = widget.initialImagePath;
      });
    }
  }

  // Select an image from the device gallery or from camera
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 160,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Scatta una foto'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() => _uploadedImagePath = image.path);
                    widget.onImageSelected(_uploadedImagePath);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Scegli dalla galleria'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() => _uploadedImagePath = image.path);
                    widget.onImageSelected(_uploadedImagePath);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to remove the selected image
  void _removeImage() {
    setState(() {
      _uploadedImagePath = null;
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
            if (_uploadedImagePath != null)
              ClipRRect( // To apply borderRadius to the image also
                borderRadius: widget.borderRadius, // Leggermente meno del bordo del container
                child: Image.file(
                  File(_uploadedImagePath!), // Image is loaded (!= null)
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover, // Cover the area maintaining the aspect ratio
                ),
              ),

            // Show "+" icon if no image is selected
            if (_uploadedImagePath == null)
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