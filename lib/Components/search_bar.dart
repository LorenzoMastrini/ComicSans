import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget{
  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    //return SearchAnchor(
      //builder: (BuildContext context, SearchController controller) {
        return SizedBox(
          width: 345,
          child: SearchBar(
            //controller: controller;
            padding: WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 10)
            ),
            leading: const Icon(Icons.search),
            hintText: 'Ricerca...',
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              )
            /*onTap:(){
              controller.openView();
            },
            onChanged: (_){
              controller.openView();
            }*/
          ),
        );
      /*suggestionsBuilder: (BuildContext context, SearchController controller){
        return List<ListTile>.generate(5, (int index){
          final String item = 'item $index';
          return ListTile(
            title: Text('item $index'),
            onTap: () {
              controller.closeView(item);
            });
        });
      }*/
  }
}