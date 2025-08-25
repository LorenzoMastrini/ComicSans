import 'package:comicsans/ComicSansTheme.dart';
import 'package:comicsans/components/ProductsGrid.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/CategoriesGrid.dart';
import 'package:comicsans/components/ComicSansSearchBar.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/providers/user_provider.dart';



class ComicSansHome extends StatefulWidget {
  final String title;
  const ComicSansHome({super.key, this.title = ""});

  @override
  State<ComicSansHome> createState() => _ComicSansHomeState();
}



class _ComicSansHomeState extends State<ComicSansHome> {
  @override
  void initState() {
    super.initState();
    _checkPurchaseStatus();
  }

  void _checkPurchaseStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      if(userProvider.justPurchased) {
        _showPurchaseDialog();
        userProvider.setJustPurchased(false); // Reset the flag
      }
    });
  }

  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Acquisto effettuato"),
        content: const Text("Il tuo acquisto è andato a buon fine!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ComicSansSearchBar(),
            SizedBox(height: 20,),
            _buildSectionTitle("Esplora"),
            CategoriesGrid(),
            _buildSectionTitle("Consigliati per te"),
            ProductsGrid(/*gridContent: GridContent.purchasableComics*/),
          ],
        ),
      ),
    );
  }
}