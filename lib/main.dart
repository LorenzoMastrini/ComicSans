import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/RouteGenerator.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:comicsans/SampleData.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SampleData.init();
  runApp(const ComicSansApp());
}



class ComicSansApp extends StatefulWidget {
  const ComicSansApp({super.key});

  @override
  State<ComicSansApp> createState() => _ComicSansAppState();
}



class _ComicSansAppState extends State<ComicSansApp> {
  final ThemeData mainTheme = ComicSansTheme.light();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ComicsProvider()),
        ChangeNotifierProvider(create: (context) => SellInfoProvider()),
        ChangeNotifierProvider(create: (context) => MessagesProvider()),
      ],
      child: SafeArea( // Avoids the UI elements of the OS
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: mainTheme.colorScheme.primary,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ComicSans",
            theme: mainTheme,
            initialRoute: '/login',
            onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          ),
        ),
      ),
    );
  }
}