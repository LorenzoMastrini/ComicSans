import 'package:comicsans/ComicSansTheme.dart';
import 'package:flutter/material.dart';
import 'screens/ComicSansHome.dart';



void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(ComicSansApp());
}



class ComicSansApp extends StatelessWidget {
  ComicSansApp({super.key});

  //final ThemeData mainTheme = ComicSansTheme.light();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ComicSans App",
      //theme: mainTheme,
      home: const ComicSansHome(title: "ComicSans App"),
    );
  }
}

