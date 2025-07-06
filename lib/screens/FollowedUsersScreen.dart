import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/FollowedUserComponent.dart';
import 'package:provider/provider.dart';



class FollowedUsersScreen extends StatelessWidget{
  const FollowedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProviderWatch = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Utenti seguiti"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
            return FollowedUserComponent(followedUser: userProviderWatch.getFollowedUsers()[index], isFollowed: true);
        },
        itemCount: userProviderWatch.getNumberOfFollowedUsers(),
        shrinkWrap: true,
      ),
    );
  }
}
