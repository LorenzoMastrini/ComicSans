import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/MainScreen.dart';
import 'package:comicsans/RouteGenerator.dart';
import 'package:comicsans/providers/SellInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ComicSansApp());
}



class ComicSansApp extends StatefulWidget {
  const ComicSansApp({super.key});

  @override
  State<ComicSansApp> createState() => _ComicSansAppState();
}

class _ComicSansAppState extends State<ComicSansApp> {
  //final ThemeData mainTheme = ComicSansTheme.light();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SellInfoProvider())
      ],
      child: const SafeArea( // Avoids the UI elements of the OS
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ComicSans",
            //theme: mainTheme,
            home: MainScreen(),
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        ),
      ),
    );
  }
}

