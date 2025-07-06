import 'package:comicsans/comic.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetailsModify.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicCardDelete.dart';
import 'package:comicsans/components/ReviewComponent.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class UserVendorScreen extends StatefulWidget{
  User user;
  UserVendorScreen({super.key, required this.user});

  @override
  State<UserVendorScreen> createState() => _UserVendorScreenState();
}

class _UserVendorScreenState extends State<UserVendorScreen> {
  late bool isFollowed;
  bool modified = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProviderWatch = context.watch<UserProvider>();
    UserProvider userProviderRead = context.read<UserProvider>();

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
                      Text(widget.user.username,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500)),
                      ReviewWidget(user: widget.user),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: userProviderWatch.getLibraryLength().toString(), style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500)),
                                  TextSpan(text: " articoli in vendita, ", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal)),
                                  TextSpan(text: widget.user.reviews.length.toString(), style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500)),
                                  TextSpan(text: " recensioni", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal)),
                                ]
                            )
                        ),
                      )
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
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return ProductDetailsModifyScreen(
                                  comic: userProviderWatch.getLibrary()[index],
                                  user: widget.user,
                                  onDelete:() {
                                    Comic comicToDelete = userProviderWatch.getLibrary()[index];
                                    userProviderRead.removeComicFromLibrary(comicToDelete);
                                  }
                                );
                              })
                            );
                          },
                          child: ComicCardDelete(
                            comic: userProviderWatch.getLibrary()[index],
                            user: userProviderWatch.loggedInUser!,
                            onDelete: () {}
                          )
                        );
                      },
                      itemCount: widget.user.getComicsSale().length,
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index){
                      return ReviewComponent(review: widget.user.reviews[index]);
                    },
                    itemCount: widget.user.reviews.length,
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
                              TextSpan(text: widget.user.sellings.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " vendite, ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal)),
                              TextSpan(text: widget.user.purchases.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
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
                        Text(widget.user.addr!.country,
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
