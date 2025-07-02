import 'package:comicsans/Components/app_bar.dart';
import 'package:comicsans/Components/comic_card_wout_button.dart';
import 'package:comicsans/screens/product_details.dart';
import 'package:flutter/material.dart';
import '../Components/comic_card.dart';
import '../user.dart';

class UserSellingsScreen extends StatefulWidget{
  User user;
  UserSellingsScreen({super.key, required this.user});

  @override
  State<UserSellingsScreen> createState() => _UserSellingsScreenState();
}

class _UserSellingsScreenState extends State<UserSellingsScreen> {
  @override
  Widget build(BuildContext context) {
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
                onTap: () async {
                  final result = await Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return ProductDetail(comic: widget.user.getSellings()[index], user: widget.user);
                      })
                  );
                  if (result == true){
                    setState(() {
                    }
                    );
                  }
                },
                child: ComicCardWoutButton(comic: widget.user.getSellings()[index], user: widget.user)
            );
          },
          itemCount: widget.user.getSellings().length,
          shrinkWrap: false,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}