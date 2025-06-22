import 'package:comicsans/comic.dart';
import 'package:comicsans/screens/image_display.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/Components/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Components/details_panel.dart';
import '../Components/review_widget.dart';

class ProductDetail extends StatefulWidget {
  final Comic comic;

  const ProductDetail({super.key, required this.comic});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int current = 0;

  final CarouselSliderController controller = CarouselSliderController();
  final PanelController panelController = PanelController();
  bool isPanelVisibile = false;

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

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
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
                        options: CarouselOptions(
                            height: 550,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                current = index;
                              });
                            }),
                        items: widget.comic.imagesPath
                            ?.map((item) => Container(
                          child: Center(
                              child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height,
                              )),
                        ))
                            .toList(),
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
                  ]),
              Row(
                // ... La tua Row con titolo, prezzo, icona spedizione e bookmark ...
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
                      icon: Icon(Icons.bookmark_border, color: Colors.black),
                      onPressed: () {},
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
                                    ReviewWidget(comic: widget.comic),
                                    GestureDetector(
                                        child: Text("Recensioni",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                decoration: TextDecoration.underline)),
                                        onTap: () {}
                                    ),
                                ]
                              )
                            ]),
                          ),
                          onTap: () {},
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: ComicSansAppBar(showBackButton: true)
      ),
      body: Stack(
        children: [
          mainContent, // Il tuo scrollabile
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // semi-trasparente
                  shadowColor: Colors.transparent, // nessuna ombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Acquista', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}