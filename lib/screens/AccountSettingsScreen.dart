import 'package:comicsans/Components/app_bar.dart';
import 'package:flutter/material.dart';
import '../user.dart';
import 'ChangeCreditCardScreen.dart';
import 'ChangeShippingAddressScreen.dart';
import 'CreditCardAccountSettingsScreen.dart';

import 'ProfileDataScreen.dart';

class AccountSettingsScreen extends StatefulWidget{
  User user;
  AccountSettingsScreen({super.key, required this.user});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComicSansAppBar(
        title: "Impostazioni",
        showBackButton: true,
      ),
      body: ListView(
        children: <Widget> [
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
                      return ProfileDataScreen(user: widget.user);
                    }
                ));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                  children: <Widget>[
                    Text("Dati profilo", style: TextStyle(color: Colors.black, fontSize: 16)),
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
                      return CreditCardAccountSettingsScreen(user: widget.user);
                    }
                ));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                  children: <Widget>[
                    Text("Pagamenti", style: TextStyle(color: Colors.black, fontSize: 16)),
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
                    return ChangeShippingAddressScreen(user: widget.user);
                  }
                ));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                  children: <Widget>[
                    Text("Spedizione", style: TextStyle(color: Colors.black, fontSize: 16)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ]
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: Row(
                    children: <Widget>[
                      Text("Disconnetti", style: TextStyle(color: Colors.black, fontSize: 16)),
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
                    Text("Elimina account", style: TextStyle(color: Colors.black, fontSize: 16)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}