import 'dart:io';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ImageUploadSlot.dart';
import 'package:comicsans/screens/ComicSansSell3.dart';
import 'package:flutter/material.dart';

class ComicSansSell2 extends StatefulWidget {
  const ComicSansSell2({super.key});

  @override
  State<ComicSansSell2> createState() => _ComicSansSell2State();
}



class _ComicSansSell2State extends State<ComicSansSell2> {

  // Grid of (maximum) 9 photos
  Widget photoGrid() {
    return GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 photos per row
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // TODO: Load photo from gallery or take a photo with camera
          },
          child: ImageUploadSlot(
            onImageSelected: (File? selectedImage) {

            },
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    const double btnBottomPadding = 15; // Bottom padding for the button
    const double btnHeight = 60;
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 2; // Space for the ListView to avoid content under the button

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: "2/3: Carica le foto",
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
                  children: [
                    const Text('Carica fino a 10 foto'),
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
                        plusDimension: 40,
                        onImageSelected: (File? selectedImage) {

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
                    Padding(
                      padding: const EdgeInsetsGeometry.directional(top: 10), // Padding from the label
                        child: photoGrid()
                    ),

                    // Prevent the content to be covered by the ElevatedButton
                    const SizedBox(height: bottomSpaceForButton),
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
                        MaterialPageRoute(
                            builder: (context) => ComicSansSell3()
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