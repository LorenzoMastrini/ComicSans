import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/user_provider.dart';

import '../Components/ComicSansAppBar.dart';
import '../Components/ComicSansButton.dart';
import '../comic.dart';
import '../components/ComicSansTextInput.dart';
import 'SearchResults.dart';

class IsbnSearchScreen extends StatefulWidget{
  @override
  State<IsbnSearchScreen> createState() => _IsbnSearchScreenState();
}

class _IsbnSearchScreenState extends State<IsbnSearchScreen> {
  late TextEditingController _isbnController;

  @override
  void initState(){
    super.initState();
    _isbnController = TextEditingController(text: '');
  }
  void dispose(){
    _isbnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ComicsProvider>();
    final providerRead = context.read<ComicsProvider>();

    return Scaffold(
      appBar: ComicSansAppBar(
        showBackButton: true,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
          child: Column(
            children: [
              ComicSansTextInput(
                title: 'ISBN',
                hintText: 'ISBN',
                labelText: 'Inserisci l\'ISBN del volume',
                controller: _isbnController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ComicSansButton (
                text: 'Ricerca',
                onPressed: () {
                  String isbnInput = _isbnController.text;
                  int? isbnInt = int.tryParse(isbnInput);

                  List<Comic> comicResult = providerRead.getPurchasableComicByISBN(context.read<UserProvider>().loggedInUser, isbnInt!);
                  print(comicResult);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SearchResults(comicsResults: comicResult, query: "")
                  ));
                },
              )
            ],
          )
        ),
      )
    );
  }
}