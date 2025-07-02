import 'package:comicsans/Components/product_grid.dart';
import 'package:comicsans/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/sample_data.dart';
import 'package:comicsans/comic.dart';
import '../Components/app_bar.dart';
import '../Components/comic_card.dart';
import '../Components/review_component.dart';
import '../Components/review_widget.dart';
import '../user.dart';

class VendorPage extends StatefulWidget{
  User seller;
  User user;
  VendorPage({super.key, required this.seller, required this.user});

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  late bool isFollowed;

  @override
  void initState(){
    super.initState();
    isFollowed = widget.user.followedUsers!.contains(widget.seller);
  }

  void toggleFavourite(){
    setState(() {
      if(isFollowed){
        widget.user.removeFollowing(widget.seller);
      }
      else{
        widget.user.addFollowing(widget.seller);
      }
      isFollowed = !isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
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
                      ReviewWidget(user: widget.seller),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 120,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            toggleFavourite();
                          },
                          child: Text(
                              isFollowed ? 'Non seguire più' : 'Segui',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: isFollowed ? 10 : 16,
                                  fontWeight: FontWeight.normal)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
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
                                    return ProductDetail(comic: widget.seller.getComicsSale()[index], user: widget.user);
                                  }
                              )
                              );
                              if (result == true){
                                setState(() {
                                }
                                );
                              }
                            },
                            child: ComicCard(comic: widget.seller.getComicsSale()[index], user: widget.user)
                        );
                      },
                      itemCount: widget.seller.getComicsSale().length,
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index){
                      return ReviewComponent(review: widget.seller.reviews![index]);
                    },
                    itemCount: widget.seller.reviews!.length,
                    shrinkWrap: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                        Text(widget.seller.addr!.country,
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
