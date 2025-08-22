import 'dart:io';

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
  late bool isFavourite;
  int current = 0;
  late ScrollController _scrollController;
  Color iconColor = Colors.white;
  final CarouselSliderController controller = CarouselSliderController();
  final PanelController panelController = PanelController();
  bool isPanelVisibile = false;
  bool changed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    double offset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    double newOpacity = (offset / 200).clamp(0.0, 1.0);

    Color newColor = newOpacity > 0.5 ? Colors.black : Colors.white;
    if (newColor != iconColor && mounted) {
      setState(() {
        iconColor = newColor;
      });
    }
  }

  Widget buildMainContent(BuildContext context) {
    final UserProvider userProviderRead = context.read<UserProvider>();
    final ComicsProvider comicsProviderRead = context.read<ComicsProvider>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SingleChildScrollView(
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
                          style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 3),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${widget.comic.price}€",
                          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500)
                        ),
                      ),
                    ),
                  ]),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.delete, color: Colors.black),
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
            Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Colors.black),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Condizioni",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(conditionsToString(widget.comic.conditions),
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Descrizione",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.comic.description,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 15, 15, 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child:
                      TextButton.icon(
                          label: Text(
                            'Dettagli',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: (){
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              ),
                              builder: (context) => DraggableScrollableSheet(
                                initialChildSize: 1.0,
                                minChildSize: 1.0,
                                maxChildSize: 1.0,
                                expand: true,
                                builder: (context, scrollController) => PanelWidget(
                                  controller: scrollController,
                                  comic: widget.comic,
                                ),
                              ),
                            );
                          }
                      )

                  ),
                ),
              ],
            ),
            SizedBox(height: 60)
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //double opacity = (_scrollController.hasClients ? _scrollController.offset / 200 : 0.0).clamp(0.0, 1.0);
    List<String> allImages = [widget.comic.coverPath] + widget.comic.otherImagesPath; // Cover image + other images

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Images carousel
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ImagesDisplay(comicImages: widget.comic.otherImagesPath),
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
                              fit: BoxFit.fill
                            )
                            : item.isEmpty || !File(item).existsSync()
                              ? Image.asset('assets/no_image.png', fit: BoxFit.fill)
                              : Image.file(
                                File(item),
                                fit: BoxFit.fill,
                              ),
                        )).toList(),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.comic.otherImagesPath.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => controller.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                      .withOpacity(current == entry.key ? 0.9 : 0.4),
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

              // Contenuto sotto
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: buildMainContent(context),
                ),
              ),
            ],
          ),

          // AppBar fissa sopra tutto
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: ComicSansAppBar(
              showBackButton: true,
              backgroundColor: Color.lerp(
                Colors.transparent,
                Colors.black,
                (_scrollController.hasClients
                    ? (_scrollController.offset / 200).clamp(0.0, 1.0)
                    : 0.0),
              ) ?? Colors.transparent,
              iconColor: Colors.white,
              actionType: AppBarActionType.overflowMenu,
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox (
        width: 350,
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
          },// Go to the main screen
        ),
      )
    );
  }
}