import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicCardWoutButton.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class UserPurchasesScreen extends StatelessWidget {
  const UserPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatch = context.watch<UserProvider>();
    return Scaffold(
      appBar: ComicSansAppBar(showBackButton: true, title: "Acquisti"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: .65,
          ),
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProductDetail(comic: userProviderWatch.getPurchases()[index])
                ));
              },
              child: ComicCardWoutButton(comic: userProviderWatch.getPurchases()[index])
            );
          },
          itemCount: userProviderWatch.getNumberOfPurchases(),
          shrinkWrap: false,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}