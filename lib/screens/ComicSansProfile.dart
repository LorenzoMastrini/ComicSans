import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/UserMovementHistory.dart';
import 'package:comicsans/screens/UserVendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:comicsans/screens/AccountSettingsScreen.dart';
import 'package:comicsans/screens/AssistanceScreen.dart';
import 'package:comicsans/screens/FollowedUsersScreen.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';


class ComicSansProfile extends StatefulWidget {
  const ComicSansProfile({super.key});
  
  @override
  State<ComicSansProfile> createState() => ComicSansProfileState();
}

class ComicSansProfileState extends State<ComicSansProfile> {
  final GlobalKey profile = GlobalKey();
  bool _showcaseStarted = false;

  void onTabVisible() {
    if (!_showcaseStarted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final userProvider = context.read<UserProvider>();
        if (!userProvider.hasSeenProfileShowcasePerUser(userProvider.loggedInUser!.id)) {
          ShowCaseWidget.of(context)?.startShowCase([profile]);
          userProvider.setHasSeenProfileShowcasePerUser(userProvider.loggedInUser!.id, true);
          _showcaseStarted = true;
          print("Showcase avviato");
        }
      });
    }
  }

  /*void startShowcaseIfNeeded() {
    print("startShowcase");
    final userProvider = context.read<UserProvider>();
    if (!_showcaseStarted && !userProvider.hasSeenProfileShowcasePerUser(userProvider.loggedInUser!.id)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ShowCaseWidget.of(context)?.startShowCase([profile]);
          userProvider.setHasSeenProfileShowcasePerUser(userProvider.loggedInUser!.id, true);
          _showcaseStarted = true;
        }
      });
    }
  }*/

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
            child: Showcase(
              key: profile,
              description: "Premi qui per vedere e modificare i tuoi fumetti in vendita",
              overlayOpacity: 0,
              disableMovingAnimation: true,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Text(
                          userProviderWatch.loggedInUser != null
                            ? userProviderWatch.loggedInUser!.username
                            : "",
                          style: TextStyle(color: Colors.black, fontSize: 24)
                        ),
                        ReviewWidget(user: userProviderWatch.loggedInUser!),
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
                builder: (context) => UserMovementHistory(movementType: MovementType.purchases)
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
                    return UserMovementHistory(movementType: MovementType.sales);
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