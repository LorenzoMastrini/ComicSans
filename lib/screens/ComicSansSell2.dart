import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ImageUploadSlot.dart';
import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:comicsans/screens/ComicSansSell3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ComicSansSell2 extends StatefulWidget {
  const ComicSansSell2({super.key});

  @override
  State<ComicSansSell2> createState() => _ComicSansSell2State();
}



class _ComicSansSell2State extends State<ComicSansSell2> {

  // Grid of (maximum) 9 photos
  Widget photoGrid(SellInfoProvider provider) {
    final otherImagesPaths = provider.otherImagesPaths;
    bool canAddImages = otherImagesPaths.length < 9;
    int totalImageCount = otherImagesPaths.length + (canAddImages ? 1 : 0);

    return GridView.builder(
      itemCount: totalImageCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 photos per row
      ),
      itemBuilder: (_, index) {
        final uploadedImagesPaths = provider.otherImagesPaths;

        // Slot for an loaded image
        if(index < uploadedImagesPaths.length) {
          final image = uploadedImagesPaths[index];
          return ImageUploadSlot(
            key: ValueKey(image),
            initialImagePath: image,
            onImageSelected: (String? selectedImagePath) {
              if (selectedImagePath != null) {
                provider.replacePhotoAt(index, selectedImagePath);
              } else {
                provider.removePhotoAt(index);
              }
            },
          );
        } else {
          return ImageUploadSlot(
            key: const ValueKey("add_new_image_slot"),
            onImageSelected: (String? selectedImagePath) {
              if (selectedImagePath != null && uploadedImagesPaths.length < 9) {
                provider.addPhoto(selectedImagePath);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Puoi caricare fino a 10 foto totali.')),
                );
              }
            },
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final sellInfoProvider = Provider.of<SellInfoProvider>(context);
    const double btnBottomPadding = 15; // Bottom padding for the button
    const double btnHeight = 60;
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 5; // Space for the ListView to avoid content under the button

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: "2/3: Carica le foto",
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
                  children: [
                    const Text('Carica fino a 10 foto (copertina inclusa)'),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Text(
                          'Foto di copertina',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '*', //required
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ]
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: ImageUploadSlot(
                        initialImagePath: sellInfoProvider.coverPath,
                        onImageSelected: (String? selectedImagePath) {
                          sellInfoProvider.updateCover(selectedImagePath);
                        }
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'Foto aggiuntive',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 30),
                    photoGrid(sellInfoProvider),

                    const SizedBox(height: bottomSpaceForButton), // Prevent the content to be covered by the ElevatedButton
                  ]
                ),

                // The button remains fixed at the bottom of the screen
                Positioned(
                  bottom: btnBottomPadding,
                  left: 0, // Must be set to center the button
                  right: 0, // Must be set to center the button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(btnHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ComicSansSell3())
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