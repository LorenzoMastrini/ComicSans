import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/ProductDetailsModify.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicCardDelete.dart';
import 'package:comicsans/components/ReviewComponent.dart';
import 'package:comicsans/components/ReviewWidget.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/ComicSansTheme.dart';



class UserVendorScreen extends StatelessWidget{
  const UserVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProviderWatch = context.watch<UserProvider>();

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
                  Icon(
                    Icons.account_circle,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 100,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userProviderWatch.loggedInUser!.username,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      ReviewWidget(user: userProviderWatch.loggedInUser!),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: userProviderWatch.getLibraryLength().toString(),
                                style: TextStyle(
                                  color: quaternary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              TextSpan(
                                text: " articoli in vendita, ",
                                style: TextStyle(
                                  color: quaternary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal
                                )
                              ),
                              TextSpan(
                                text: userProviderWatch.getNumberOfReviews().toString(),
                                style: TextStyle(
                                  color: quaternary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              TextSpan(
                                text: " recensioni",
                                style: TextStyle(
                                  color: quaternary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal
                                )
                              ),
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
              labelStyle: Theme.of(context).textTheme.headlineSmall,
              unselectedLabelColor: Colors.grey,
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
                              builder: (context) =>
                                  ProductDetailsModifyScreen(comic: userProviderWatch.getLibrary()[index])
                            ));
                          },
                          child: ComicCardDelete(
                            comic: userProviderWatch.getLibrary()[index],
                            onDelete: () {}
                          )
                        );
                      },
                      itemCount: userProviderWatch.getLibraryLength(),
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) => ReviewComponent(review: userProviderWatch.loggedInUser!.reviews[index]),
                    itemCount: userProviderWatch.getNumberOfReviews(),
                    shrinkWrap: true,
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
                              TextSpan(text: userProviderWatch.getNumberOfSales().toString(), style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " vendite, ", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.normal)),
                              TextSpan(text: userProviderWatch.getNumberOfPurchases().toString(), style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                              TextSpan(text: " acquisti", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18, fontWeight: FontWeight.normal))
                            ]
                          )
                        ),
                        SizedBox(height: 30),
                        Text("Posizione",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(userProviderWatch.loggedInUser!.address?.country ?? '',
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
