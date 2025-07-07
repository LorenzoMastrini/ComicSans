import 'package:comicsans/Components/ComicSansAppBar.dart';
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
      appBar: ComicSansAppBar(
        title: 'Utenti seguiti',
        showBackButton: true,
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
