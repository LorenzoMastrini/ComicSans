import 'package:comicsans/comic.dart';
import 'package:comicsans/screens/ImagesDisplay.dart';
import 'package:comicsans/screens/PurchaseScreen.dart';
import 'package:comicsans/screens/VendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../Components/ComicSansButton.dart';
import '../Components/PanelWidget.dart';
import '../Components/ReviewWidget.dart';
import '../user.dart';

class ProductDetail extends StatefulWidget {
  final Comic comic;
  final User user;

  const ProductDetail({super.key, required this.comic, required this.user});
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
    isFavourite = widget.user.checkFavourites(widget.user, widget.comic);

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

  String formatCondition(Conditions cond) {
    switch (cond) {
      case Conditions.DaEdicola:
        return "Da edicola";
      case Conditions.Ottime:
        return "Ottime";
      case Conditions.Buone:
        return "Buone";
      case Conditions.MoltoUsato:
        return "Molto usata";
      default:
        return cond.toString().split('.').last;
    }
  }

  void toggleFavourite(){
    setState(() {
      if(isFavourite){
        widget.user.removeFavourite(widget.comic);
      }
      else{
        widget.user.addFavourite(widget.comic);
      }
      isFavourite = !isFavourite;
      changed = true;
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
                                style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 3),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.comic.price.toString() + "€",
                                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500)),
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
                              child: Text("Spedizione a partire da: 0€",
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
                                    Text(widget.comic.seller!.username,
                                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                                    ReviewWidget(user: widget.comic.seller),
                                    GestureDetector(
                                      child: Text("Recensioni",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              decoration: TextDecoration.underline)),
                                    ),
                                  ]
                              )
                            ]),
                          ),
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context){
                                  return VendorScreen(seller: widget.comic.seller, user: widget.user);
                                }
                            )
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Row(children: <Widget>[
                            Icon(FontAwesomeIcons.locationDot, color: Colors.black, size: 25),
                            Text(widget.comic.seller!.addr!.country,
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                          ]),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Chat', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
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
                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.comic.cond != null ? formatCondition(widget.comic.cond!) : "N/D",
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
    double opacity = (_scrollController.hasClients ? _scrollController.offset / 200 : 0.0).clamp(0.0, 1.0);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, changed);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Scrollable content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Carosello immagine
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ImagesDisplay(comicImages: widget.comic.imagesPath),
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
                            onPageChanged: (index, reason) {
                              setState(() {
                                current = index;
                              });
                            },
                          ),
                          items: widget.comic.imagesPath?.map((item) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.asset(
                              item,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              alignment: Alignment.center,
                            ),
                          )).toList(),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.comic.imagesPath!.asMap().entries.map((entry) {
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
                backgroundColor: Color.lerp(Colors.transparent, Colors.black, opacity),
                iconColor: Colors.white,
                modified: changed,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
          SizedBox(
            width: 350,
            child: ComicSansButton (
              text: 'Acquista',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return PurchaseScreen(comic: widget.comic, user: widget.user);
                    }
                  )
                );
              },// Go to the main screen
            ),
          ),
        ),
      );
  }
}