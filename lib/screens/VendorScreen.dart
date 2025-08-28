import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/components/ReviewComponent.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';



class VendorScreen extends StatefulWidget{
  final User seller;
  final int initialTab;
  const VendorScreen({super.key, required this.seller, this.initialTab = 0});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}


class _VendorScreenState extends State<VendorScreen> {
  late bool isFollowed;

  void toggleFollow() {
    final userProviderRead = context.read<UserProvider>();

    setState(() {
      isFollowed
          ? userProviderRead.removeFollowing(widget.seller)
          : userProviderRead.addFollowing(widget.seller);
      isFollowed = !isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProviderWatch = context.watch<UserProvider>();
    isFollowed = userProviderWatch.getFollowedUsers().contains(widget.seller);

    return DefaultTabController(
      length: 3,
      initialIndex: widget.initialTab,
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: ComicSansAppBar(showBackButton: true, actionType: AppBarActionType.overflowMenu)
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 0, 0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle, color: Theme.of(context).colorScheme.secondary, size: 100),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.seller.username,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      ReviewWidget(user: widget.seller),
                      SizedBox(height: 8),
                      SizedBox(
                        width: isFollowed ? 145 : 120,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () => toggleFollow(),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            isFollowed ? 'Non seguire più' : 'Segui',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: isFollowed ? 10 : 12,
                              letterSpacing: 0.1
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            TabBar(
              tabs: [
                Tab(text: "Libreria"),
                Tab(text: "Recensioni"),
                Tab(text: "Informazioni")
              ],
              labelColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.secondary,
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: GridView.builder(
                      itemCount: widget.seller.getComicsSale().length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: .65,
                      ),
                      itemBuilder: (context, index) {
                        final comic = widget.seller.getComicsSale()[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ProductDetail(comic: comic)
                            ));
                          },
                          child: ShowCaseWidget(builder: (context) => ComicCard(comic: comic))
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    itemCount: widget.seller.reviews.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ReviewComponent(review: widget.seller.reviews[index])
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Statistiche",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: widget.seller.sellings.length.toString(), style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " vendite, ", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.normal)),
                              TextSpan(text: widget.seller.purchases.length.toString(), style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " acquisti", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.normal))
                            ]
                          )
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Posizione",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(widget.seller.address!.country,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
