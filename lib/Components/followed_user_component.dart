import 'package:comicsans/Components/review_component.dart';
import 'package:comicsans/Components/review_widget.dart';
import 'package:flutter/material.dart';
import '../user.dart';

class FollowedUserComponent extends StatefulWidget{
  User user;
  User followedUser;
  bool isFollowed;
  FollowedUserComponent({super.key, required this.user, required this.isFollowed, required this.followedUser});

  @override
  State<FollowedUserComponent> createState() => _FollowedUserComponentState();
}

class _FollowedUserComponentState extends State<FollowedUserComponent> {
  void toggleFavourite(){
    setState(() {
      if(widget.isFollowed){
        widget.user.removeFollowing(widget.followedUser);
      }
      else{
        widget.user.addFollowing(widget.followedUser);
      }
      widget.isFollowed = !widget.isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
            Row(
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.black, size: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.followedUser.username, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                  ReviewWidget(user: widget.followedUser),
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
                    child: Text(
                        widget.isFollowed ? 'Non seguire più' : 'Segui',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: widget.isFollowed ? 10 : 16,
                            fontWeight: FontWeight.normal)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
          Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: Colors.black),
        ],
      ),
    );
  }
}