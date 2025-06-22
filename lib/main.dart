//import 'package:comicsans/ComicSansTheme.dart';
//import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/screens/ComicSansHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "ComicSans App",
          //theme: mainTheme,
          home: ComicSansHome(title: ""),
        ),
      ),
    );
  }
}

