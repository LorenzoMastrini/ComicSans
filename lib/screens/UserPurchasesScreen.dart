import 'package:comicsans/Components/app_bar.dart';
import 'package:comicsans/Components/comic_card_wout_button.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import '../Components/ComicCard.dart';
import '../user.dart';

class UserPurchasesScreen extends StatefulWidget{
  User user;
  UserPurchasesScreen({super.key, required this.user});

  @override
  State<UserPurchasesScreen> createState() => _UserPurchasesScreenState();
}

class _UserPurchasesScreenState extends State<UserPurchasesScreen> {
  @override
  Widget build(BuildContext context) {
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
                onTap: () async {
                  final result = await Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return ProductDetail(comic: widget.user.getPurchases()[index], user: widget.user);
                      })
                  );
                  if (result == true){
                      setState(() {
                      }
                    );
                  }
                },
                child: ComicCardWoutButton(comic: widget.user.getPurchases()[index], user: widget.user)
            );
          },
          itemCount: widget.user.getPurchases().length,
          shrinkWrap: false,
          padding: EdgeInsets.zero,
        ),
      ),
   );
  }
}