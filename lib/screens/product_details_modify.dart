import 'package:comicsans/comic.dart';
import 'package:comicsans/screens/image_display.dart';
import 'package:comicsans/screens/purchase_screen.dart';
import 'package:comicsans/screens/user_vendor_screen.dart';
import 'package:comicsans/screens/vendor_screen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../Components/details_panel.dart';
import '../Components/review_widget.dart';
import '../sample_data.dart';
import '../user.dart';

class ProductDetailsModifyScreen extends StatefulWidget {
  final Comic comic;
  final User user;
  final VoidCallback onDelete;
  const ProductDetailsModifyScreen({super.key, required this.comic, required this.user, required this.onDelete});
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
                      ]),
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () async {
                        bool? confirm = await showDialog<bool>(
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
                                onPressed: (){
                                  widget.user.removeComicsSale(widget.comic);
                                  SampleData.allComics.removeWhere((c) => c.id == widget.comic.id);
                                  Navigator.of(context).pop(true);
                                  widget.onDelete();
                                  /*Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context){
                                      return UserVendorScreen(user: widget.user);
                                    })
                                  );*/
                                  Navigator.pop(context, true);
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
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          child:
                          Text("Dettagli",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500, decoration: TextDecoration.underline)),
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
    double opacity = (_scrollController.hasClients ? _scrollController.offset / 200 : 0.0).clamp(0.0, 1.0);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, changed);
        return false;
      },
      child: Scaffold(
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
                                builder: (context){
                                  return ImagesDisplay(comicImages: widget.comic.imagesPath);
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
                            items: widget.comic.imagesPath?.map((item) => Container(
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
                          child: Container(
                            child: ComicSansAppBar(
                              showBackButton: true,
                              backgroundColor: Colors.white.withOpacity(opacity),
                              iconColor: iconColor,
                              modified: changed,
                            ),
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
              /*Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return PurchaseScreen(comic: widget.comic, user: widget.user);
                  }
              )
              );*/
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Modifica', style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}