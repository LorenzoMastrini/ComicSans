import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/UserPurchasesScreen.dart';
import 'package:comicsans/screens/UserSellingsScreen.dart';
import 'package:comicsans/screens/UserVendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:comicsans/screens/AccountSettingsScreen.dart';
import 'package:comicsans/screens/AssistanceScreen.dart';
import 'package:comicsans/screens/FollowedUsersScreen.dart';
import 'package:provider/provider.dart';



class ComicSansProfile extends StatelessWidget {
  const ComicSansProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProviderWatch = context.watch<UserProvider>();

    return ListView(
      children: <Widget> [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserVendorScreen()
              ));
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
                      Text(userProviderWatch.loggedInUser!.username, style: TextStyle(color: Colors.black, fontSize: 24)),
                      ReviewWidget(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: userProviderWatch.getLibraryLength().toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                              TextSpan(text: " articoli in vendita, ", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal)),
                              TextSpan(text: userProviderWatch.getNumberOfReviews().toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
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
                builder: (context) => UserPurchasesScreen()
              ));
            },
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
                    return UserSellingsScreen();
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
                  builder: (context) => FollowedUsersScreen()
              ));
            },
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
                  builder: (context) => AccountSettingsScreen()
                ));
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