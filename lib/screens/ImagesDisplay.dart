import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          ComicSansAppBar(showBackButton: true),
          Expanded(
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
              items: widget.comicImages
                  ?.map((item) => Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                    )),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}