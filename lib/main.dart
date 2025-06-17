import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:flutter/material.dart';
import 'screens/ComicSansHome.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ComicSansApp());
}



class ComicSansApp extends StatefulWidget {
  ComicSansApp({super.key});

  @override
  State<ComicSansApp> createState() => _ComicSansAppState();
}

class _ComicSansAppState extends State<ComicSansApp> {
  //final ThemeData mainTheme = ComicSansTheme.light();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ComicSans App",
      //theme: mainTheme,
      home: ComicSansBottomBar(),
    );
  }
}

