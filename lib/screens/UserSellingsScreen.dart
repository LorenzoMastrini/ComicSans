import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicCardWoutButton.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class UserSellingsScreen extends StatefulWidget{
  const UserSellingsScreen({super.key});

  @override
  State<UserSellingsScreen> createState() => _UserSellingsScreenState();
}



class _UserSellingsScreenState extends State<UserSellingsScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatch = context.watch<UserProvider>();

    return Scaffold(
      appBar: ComicSansAppBar(showBackButton: true, title: "Vendite"),
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
                    builder: (context) => ProductDetail(comic: userProviderWatch.getSellings()[index])
                ));
              },
              child: ComicCardWoutButton(comic: userProviderWatch.getSellings()[index])
            );
          },
          itemCount: userProviderWatch.getNumberOfSellings(),
          shrinkWrap: false,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}