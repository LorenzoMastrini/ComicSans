import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicCard.dart';
import 'package:comicsans/components/ReviewComponent.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class VendorScreen extends StatefulWidget{
  final User seller;

  const VendorScreen({super.key, required this.seller});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}



class _VendorScreenState extends State<VendorScreen> {
  late bool isFollowed;

  void _toggleFollow() {
    final userProviderRead = context.watch<UserProvider>();

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
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: ComicSansAppBar(showBackButton: true)
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 0, 0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle, color: Colors.black, size: 100),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.seller.username,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                      ReviewWidget(),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 120,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            _toggleFollow();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            isFollowed ? 'Non seguire più' : 'Segui',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isFollowed ? 10 : 16,
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
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
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
                              builder: (_) =>
                                  ProductDetail(comic: comic)
                            ));
                          },
                          child: ComicCard(comic: comic)
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
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: widget.seller.sellings.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " vendite, ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                              TextSpan(text: widget.seller.purchases.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " acquisti", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal))
                            ]
                          )
                        ),
                        SizedBox(height: 30),
                        Text("Posizione",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(widget.seller.address!.country,
                          style: TextStyle(
                            color: Colors.black,
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
