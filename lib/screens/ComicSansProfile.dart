import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansBottomBar.dart';
import 'package:comicsans/screens/Profile.dart';
import 'package:comicsans/screens/UserPurchasesScreen.dart';
import 'package:comicsans/screens/UserSellingsScreen.dart';
import 'package:comicsans/screens/UserVendorScreen.dart';
import 'package:flutter/material.dart';

import '../Components/ReviewWidget.dart';
import '../user.dart';
import 'AccountSettingsScreen.dart';
import 'AssitanceScreen.dart';
import 'FollowedUsersScreen.dart';

class ComicSansProfile extends StatefulWidget {
  User user;
  ComicSansProfile({super.key, required this.user});

  @override
  State<ComicSansProfile> createState() => _ComicSansProfileState();
}

class _ComicSansProfileState extends State<ComicSansProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget> [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () async {
              final result = await Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return UserVendorScreen(user: widget.user);
                  })
              );
              if (result == true){
                setState(() {
                }
                );
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                          Text(widget.user.username, style: TextStyle(color: Colors.black, fontSize: 24)),
                          ReviewWidget(user: widget.user),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: widget.user.comicsSale.length.toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                      TextSpan(text: " articoli in vendita, ", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal)),
                                      TextSpan(text: widget.user.reviews.length.toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                      TextSpan(text: " recensioni", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal)),
                                    ]
                                )
                            ),
                          )
                        ]
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ]
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return UserPurchasesScreen(user: widget.user);
                  })
              );},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
                children: <Widget>[
                  Text("Acquisti effettuati", style: TextStyle(color: Colors.black, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ]
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return UserSellingsScreen(user: widget.user);
                  })
              );},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
                children: <Widget>[
                  Text("Vendite effettuate", style: TextStyle(color: Colors.black, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ]
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return FollowedUsersScreen(user: widget.user);
                  })
              );},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
                children: <Widget>[
                  Text("Account seguiti", style: TextStyle(color: Colors.black, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ]
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black, width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return AccountSettingsScreen(user: widget.user);
                    })
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                  children: <Widget>[
                    Text("Impostazioni account", style: TextStyle(color: Colors.black, fontSize: 16)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ]
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return Assistance();
                  })
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
                children: <Widget>[
                  Text("Assistenza", style: TextStyle(color: Colors.black, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ]
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
                children: <Widget>[
                  Text("Invia un feedback", style: TextStyle(color: Colors.black, fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.black),
                ]
            ),
          ),
        ),
      ],
    );
  }
}