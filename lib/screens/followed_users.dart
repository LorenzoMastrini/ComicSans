import 'package:flutter/material.dart';
import '../Components/followed_user_component.dart';
import '../user.dart';

class FollowedUsersScreen extends StatefulWidget{
  User user;
  FollowedUsersScreen({super.key, required this.user});

  @override
  State<FollowedUsersScreen> createState() => _FollowedUsersScreenState();
}

class _FollowedUsersScreenState extends State<FollowedUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utenti seguiti"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
            return FollowedUserComponent(user: widget.user, followedUser: widget.user.followedUsers[index], isFollowed: true);
        },
        itemCount: widget.user.followedUsers!.length,
        shrinkWrap: true,
      ),
    );
  }
}
