import 'package:flutter/material.dart';
import 'screens/ComicSansHome.dart';



void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const ComicSansApp());
}



class ComicSansApp extends StatelessWidget {
  const ComicSansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ComicSans App",
      home: ComicSansHome(title: "ComicSans App"),
    );
  }
}

