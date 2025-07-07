import 'package:comicsans/components/ProductGrid.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/CategoriesGrid.dart';
import 'package:comicsans/components/ComicSansSearchBar.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';



class ComicSansHome extends StatefulWidget {
  final String title;
  const ComicSansHome({super.key, this.title = ""});

  @override
  State<ComicSansHome> createState() {
    return _ComicSansHomeState();
  }
}

class _ComicSansHomeState extends State<ComicSansHome> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      if (userProvider.justPurchased) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Acquisto effettuato"),
            content: Text("Il tuo acquisto è andato a buon fine!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          ),
        );
        userProvider.setJustPurchased(false); // resetta il flag
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ComicSansSearchBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Esplora",
                  style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            CategoriesGrid(),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Consigliati per te",
                    style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}