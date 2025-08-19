import 'package:comicsans/Chat.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ComicSansInbox extends StatelessWidget {
  const ComicSansInbox({super.key});

  @override
  Widget build(BuildContext context) {
    final MessagesProvider messagesProviderWatch = context.watch<MessagesProvider>();

    return Column(
      children: [
        ComicSansAppBar(title: 'Messaggi',),
        // List of chats of the current user
        ListView.builder(
          itemBuilder: (context, index) =>
            _buildChatComponent(context: context, chat: messagesProviderWatch.chats[index], itemIndex: index),
          itemCount: messagesProviderWatch.chats.length,
          shrinkWrap: true,
        ),
      ],
    );
  }

  Widget _buildChatComponent({required BuildContext context, required Chat chat, required int itemIndex}) {
    bool isFirstItem = itemIndex == 0 ? true : false; // Borders of the first element are different

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: isFirstItem ? BorderSide(color: Colors.grey, width: 1) : BorderSide.none, // Avoid overlapping borders
            bottom: BorderSide(color: Colors.grey, width: 1),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.black, size: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(usernameToDisplay(context, chat),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(chat.product.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ]
              ),
              Spacer(),
      
              const SizedBox(width: 70),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: chat.newMessages
                        ? Icon(Icons.circle, color: Colors.blue, size: 10)
                        : null,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Text(
                        formatDate(chat.messages.last.date),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ]
          ),
        ),
      ),

      onTap: () => Navigator.pushNamed(context, '/chat', arguments: chat),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
           "${date.month.toString().padLeft(2, '0')}/"
           "${date.year}";
  }
}