import 'package:flutter/material.dart';
import 'package:comicsans/category.dart';
import 'package:provider/provider.dart';

import '../Components/ComicSansAppBar.dart';
import '../comic.dart';
import '../components/ComicCard.dart';
import '../providers/user_provider.dart';
import 'ProductDetail.dart';

class CategoryScreen extends StatefulWidget{
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final userProviderWatch = context.watch<UserProvider>();
    final List<Comic> comicsList = userProviderWatch.getPurchasableComics();
    final Map<String, String> categoryToCountry = {
      'Italiano': 'Italia',
      'Americano': 'USA',
      'Giapponese': 'Giappone',
      'Francese': 'Francia',
    };
    final String mappedCountry = categoryToCountry[widget.categoryName] ?? '';
    final List<Comic> filteredComics = comicsList.where((comic) => comic.country == mappedCountry).toList();

    return Scaffold(
      appBar: ComicSansAppBar(
        showBackButton: true,
        title: widget.categoryName,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: .65,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProductDetail(comic: filteredComics[index])
                  ));
                },
                child: ComicCard(comic: filteredComics[index])
            );
          },
          itemCount: filteredComics.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}