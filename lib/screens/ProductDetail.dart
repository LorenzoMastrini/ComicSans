import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ImagesDisplay.dart';
import 'package:comicsans/screens/PurchaseScreen.dart';
import 'package:comicsans/screens/VendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:comicsans/components/PanelWidget.dart';
import 'package:comicsans/components/ReviewWidget.dart';



class ProductDetail extends StatefulWidget {
  final Comic comic;

  const ProductDetail({super.key, required this.comic});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}



class _ProductDetailState extends State<ProductDetail> {
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
    // Safe access to provider without triggering rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      isFavourite = userProvider.checkFavorite(widget.comic);
      setState(() {});
    });
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

  void toggleFavourite(){
    final userProviderRead = context.read<UserProvider>();

    setState(() {
      changed = true;
      isFavourite
        ? userProviderRead.removeFavorite(widget.comic)
        : userProviderRead.addFavorite(widget.comic);
      isFavourite = !isFavourite;
    });
  }

  Widget buildMainContent(BuildContext context) {
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
                        child: Text(widget.comic.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w500
                          ),
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                          child: Icon(FontAwesomeIcons.truck, color: Colors.black, size: 18)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Spedizione a partire da: 0€",
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ]),
                    ),
                  ]),
                ),
                IconButton(
                  iconSize: 40,
                  icon: isFavourite ? Icon(Icons.bookmark, color: Colors.black) : Icon(Icons.bookmark_border, color: Colors.black),
                  onPressed: () async {
                    if (isFavourite) {
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
                        toggleFavourite();
                      }
                    }
                    else {
                      toggleFavourite(); // aggiunta diretta senza conferma
                    }
                  },
                )
              ]),
            Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Colors.black),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Row(children: <Widget>[
                          Icon(Icons.account_circle, color: Colors.black, size: 80),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.comic.seller.username,
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                              ReviewWidget(),
                              GestureDetector(
                                child: Text("Recensioni",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline
                                  )
                                ),
                              ),
                            ]
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => VendorScreen(seller: widget.comic.seller)
                        ));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(children: <Widget>[
                        Icon(FontAwesomeIcons.locationDot, color: Colors.black, size: 25),
                        Text(
                          widget.comic.seller.address!.country,
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                      ]),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                      )
                    ),
                  ),
                )
              ]
            ),
            Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Colors.black),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Condizioni",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      )
                    ),
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
                    child: Text(
                      "Descrizione",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.comic.description,
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child:
                      Text("Dettagli",
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline
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
                      }),
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
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 550,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double appBarHeight = constraints.biggest.height;
                double opacity = 0.0;
                if (appBarHeight <= kToolbarHeight + 50) {
                  opacity = 1.0;
                }

                return Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ImagesDisplay(comicImages: widget.comic.otherImagesPath);
                          }
                        )
                        );
                      },
                      child: CarouselSlider(
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 550,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              current = index;
                            });
                          }),
                        items: widget.comic.otherImagesPath.map((item) => SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset(
                            item,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center
                          ),
                        )).toList(),
                      ),
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
                                  .withOpacity(current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Container(
                        color: Colors.white.withOpacity(opacity),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: ComicSansAppBar(
                        showBackButton: true,
                        backgroundColor: Colors.white.withOpacity(opacity),
                        iconColor: iconColor,
                      ),
                    ),
                  ]
                );
              },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width - 30,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return PurchaseScreen(comic: widget.comic);
                }
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Acquista', style: TextStyle(color: Colors.black)),
          ),
        ),
      );
  }
}