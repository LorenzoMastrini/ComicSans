import 'package:comicsans/components/ReviewWidget.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class FollowedUserComponent extends StatefulWidget{
  User followedUser;
  bool isFollowed;
  FollowedUserComponent({super.key, required this.isFollowed, required this.followedUser});

  @override
  State<FollowedUserComponent> createState() => _FollowedUserComponentState();
}



class _FollowedUserComponentState extends State<FollowedUserComponent> {
  void toggleFavourite() {
    final UserProvider userProviderRead = context.read<UserProvider>();

    setState(() {
      if(widget.isFollowed) {
        userProviderRead.removeFollowing(widget.followedUser);
      }
      else {
        userProviderRead.addFollowing(widget.followedUser);
      }
      widget.isFollowed = !widget.isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
        children: <Widget>[
          Icon(Icons.account_circle, color: Colors.black, size: 70),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.followedUser.username, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
              ReviewWidget(),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: SizedBox(
              width: 120,
              height: 25,
              child: ElevatedButton(
                onPressed: () {
                  toggleFavourite();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  widget.isFollowed ? 'Non seguire più' : 'Segui',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.isFollowed ? 10 : 16,
                    fontWeight: FontWeight.normal)),
              ),
            ),
          ),
        ]
        ),
        Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Colors.black),
      ],
    );
  }
}