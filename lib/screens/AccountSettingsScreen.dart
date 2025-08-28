import 'package:comicsans/Chat.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ChangeShippingAddressScreen.dart';
import 'CreditCardAccountSettingsScreen.dart';
import 'ProfileDataScreen.dart';



class AccountSettingsScreen extends StatelessWidget{
  const AccountSettingsScreen({super.key});

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
                top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProfileDataScreen()
                ));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                children: <Widget>[
                  Text("Dati profilo", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
                ]
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreditCardAccountSettingsScreen()
                ));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                children: <Widget>[
                  Text("Pagamenti", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
                ]
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ChangeShippingAddressScreen()
                ));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: Row(
                children: <Widget>[
                  Text("Spedizione", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
                ]
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                  bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  final UserProvider userProviderRead = context.read<UserProvider>();
                  final SellInfoProvider sellInformationsProviderRead = context.read<SellInfoProvider>();
                  // Clear all providers data
                  userProviderRead.resetInformations();
                  sellInformationsProviderRead.resetInformations();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: Row(
                  children: <Widget>[
                    Text("Disconnetti", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w500)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
                  ]
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
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
                  Text("Elimina account", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}