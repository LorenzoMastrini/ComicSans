import 'dart:io';
import 'package:comicsans/Chat.dart';
import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ChatScreen.dart';
import 'package:comicsans/screens/ImagesDisplay.dart';
import 'package:comicsans/screens/PurchaseScreen.dart';
import 'package:comicsans/screens/VendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/components/PanelWidget.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:showcaseview/showcaseview.dart';



class ProductDetail extends StatefulWidget {
  final Comic comic;

  const ProductDetail({super.key, required this.comic});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}



class _ProductDetailState extends State<ProductDetail> {
  int current = 0;
  final CarouselSliderController controller = CarouselSliderController();
  final GlobalKey favourite = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleFavourite(bool isFavorite, UserProvider provider) {
    if (isFavorite) {
      provider.removeFavorite(widget.comic);
    } else {
      provider.addFavorite(widget.comic);
    }
  }

  Widget buildMainContent(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final isFavorite = userProvider.isFavorite(widget.comic);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 3, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.comic.title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.visible,
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                            child: Icon(FontAwesomeIcons.truck, color: quaternary, size: 18),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              " Spedizione a partire da: 0€",
                              style: TextStyle(color: quaternary, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 40,
                icon: isFavorite
                    ? Icon(Icons.bookmark, color: Theme.of(context).colorScheme.secondary)
                    : Icon(Icons.bookmark_border, color: Theme.of(context).colorScheme.secondary),
                onPressed: () async {
                  if (isFavorite) {
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text("Sei sicuro di voler rimuovere questo fumetto dai preferiti?"),
                        actions: [
                          TextButton(
                            child: Text("Annulla"),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            child: Text("Conferma"),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      toggleFavourite(isFavorite, userProvider);
                    }
                  } else {
                    toggleFavourite(isFavorite, userProvider); // Adding is direct, without confirmation
                  }
                },
              ),
            ],
          ),
          Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Theme.of(context).colorScheme.secondary),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(children: <Widget>[
                          Icon(Icons.account_circle, color: Theme.of(context).colorScheme.secondary, size: 80),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.comic.seller.username,
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                              ReviewWidget(user: widget.comic.seller),
                              GestureDetector(
                                child: Text("Recensioni",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline
                                  )
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VendorScreen(seller: widget.comic.seller, initialTab: 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VendorScreen(seller: widget.comic.seller, initialTab: 0),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9),
                            child: Icon(FontAwesomeIcons.locationDot, color: quaternary, size: 18),
                          ),
                          Text(
                            widget.comic.seller.address!.country,
                            style: TextStyle(color: quaternary, fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ShowCaseWidget(
                        builder: (context) => ChatScreen(
                          chat: Chat(
                            [],
                            userProvider.loggedInUser!,
                            widget.comic.seller,
                            widget.comic,
                            false,
                          ),
                        ),
                      ),
                    ));
                  },
                  child: Text(
                    "Chat",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                        color: Theme.of(context).colorScheme.secondary
                    ),
                  )
                ),
              ),
            ],
          ),
          Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Theme.of(context).colorScheme.secondary),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Condizioni", style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    conditionsToString(widget.comic.conditions),
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Descrizione", style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.comic.description,
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15),
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
                        decorationColor: quaternary,
                      ),
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
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> allImages = [widget.comic.coverPath] + widget.comic.otherImagesPath; // Cover image + other images

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
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
                        items: allImages.map((item) {
                          return SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: item.startsWith('assets/')
                                ? Image.asset(
                              item,
                              fit: BoxFit.fill,
                            )
                                : item.isEmpty || !File(item).existsSync()
                                ? Image.asset('assets/no_image.png', fit: BoxFit.fill)
                                : Image.file(
                              File(item),
                              fit: BoxFit.fill,
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: allImages.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => controller.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark
                                      ? Theme.of(context).colorScheme.tertiary
                                      : Theme.of(context).colorScheme.secondary)
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
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: ComicSansAppBar(
              showBackButton: true,
              backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(100),
              iconColor: Theme.of(context).colorScheme.tertiary,
              actionType: AppBarActionType.overflowMenu,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: ComicSansButton(
          text: 'Acquista',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PurchaseScreen(comic: widget.comic),
            ));
          },
        ),
      ),
    );
  }
}
