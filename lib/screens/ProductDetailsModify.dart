import 'dart:io';
import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ComicSansSell1.dart';
import 'package:comicsans/screens/ImagesDisplay.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:comicsans/components/PanelWidget.dart';
import 'package:comicsans/components/ComicSansButton.dart';



class ProductDetailsModifyScreen extends StatefulWidget {
  final Comic comic;
  const ProductDetailsModifyScreen({super.key, required this.comic});
  @override
  State<ProductDetailsModifyScreen> createState() => _ProductDetailsModifyScreenState();
}



class _ProductDetailsModifyScreenState extends State<ProductDetailsModifyScreen> {
  int current = 0;
  final CarouselSliderController controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildMainContent(BuildContext context) {
    final UserProvider userProviderRead = context.read<UserProvider>();
    final ComicsProvider comicsProviderRead = context.read<ComicsProvider>();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 3, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.comic.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.comic.price}€",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible
                        )
                      ),
                    ),
                  ),
                ]),
              ),
              IconButton(
                iconSize: 40,
                icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("Sei sicuro di voler rimuovere questo annuncio?"),
                      actions: [
                        TextButton(
                          child: Text("Annulla"),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: Text("Conferma"),
                          onPressed: () {
                            userProviderRead.removeComicFromLibrary(widget.comic);
                            comicsProviderRead.removeComic(widget.comic);
                            Navigator.pop(context, true); // Close the dialog
                            Navigator.pop(context, true); // Close the product page (product doesn't exist anymore)
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            ]),
          Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Theme.of(context).colorScheme.secondary),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Condizioni",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    conditionsToString(widget.comic.conditions),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Descrizione",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.comic.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Text(
                      "Dettagli",
                      style: TextStyle(
                        color: quaternary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: quaternary
                      )
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        builder: (context) => DraggableScrollableSheet(
                          initialChildSize: 0.85,
                          minChildSize: 0.85,
                          maxChildSize: 0.85,
                          expand: false,
                          builder: (context, scrollController) => PanelWidget(
                            controller: scrollController,
                            comic: widget.comic,
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60)
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> allImages = [widget.comic.coverPath] + widget.comic.otherImagesPath; // Cover image + other images

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            slivers: [
              // Images carousel
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ImagesDisplay(comicImages: allImages),
                    ));
                  },
                  child: Stack(
                    children: [
                      CarouselSlider(
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 550,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: allImages.length > 1,
                          scrollPhysics: allImages.length > 1
                              ? const PageScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          onPageChanged: (index, reason) {
                            setState(() {
                              current = index;
                            });
                          },
                        ),
                        items: allImages.map((item) => SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: item.startsWith('assets/')
                            ? Image.asset(
                              item,
                              fit: BoxFit.fitHeight
                            )
                            : item.isEmpty || !File(item).existsSync()
                              ? Image.asset('assets/no_image.png', fit: BoxFit.fitHeight)
                              : Image.file(
                                File(item),
                                fit: BoxFit.fitHeight,
                              ),
                        )).toList(),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:allImages.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => controller.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).colorScheme.secondary)
                                      .withAlpha(current == entry.key ? 210 : 105),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: buildMainContent(context),
                ),
              ),
            ],
          ),

          // Fixed AppBar in overlay with the images
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: ComicSansAppBar(
              showBackButton: true,
              backgroundColor:Theme.of(context).colorScheme.secondary.withAlpha(100),
              iconColor: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox (
        width: MediaQuery.of(context).size.width - 30,
        child: ComicSansButton (
          text: 'Modifica',
          onPressed: () {
            // Use same approach as selling an item
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext modalContext) {
                return ComicSansSell1(comicToModify: widget.comic,);
              },
            );
          },
        ),
      )
    );
  }
}