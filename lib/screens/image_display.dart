import 'package:flutter/material.dart';
import 'package:comicsans/Components/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ImagesDisplay extends StatefulWidget{
  final List<String> comicImages;

  ImagesDisplay({super.key, required this.comicImages});

  @override
  State<ImagesDisplay> createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesDisplay> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ComicSansAppBar(showBackButton: true),
        CarouselSlider(
          options: CarouselOptions(
              height: 550,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  current = index;
                });
              }),
          items: widget.comicImages
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
      ],
    );
  }
}