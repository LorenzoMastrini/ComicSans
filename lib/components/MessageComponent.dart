import 'package:comicsans/Chat.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/OfferScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageComponent extends StatelessWidget {
  final Chat chat;
  final Message message;

  const MessageComponent({super.key, required this.chat, required this.message});

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.normal:
        return _buildNormalMessage(context, message);
      case MessageType.offer:
        return _buildOfferMessage(context, message);
      case MessageType.acceptOffer:
        return _buildAcceptOfferMessage();
    }
  }

  Widget _buildNormalMessage(BuildContext context, Message message) {
    final bool isSentByCurrentUser = message.sender == context.watch<UserProvider>().loggedInUser;

    return Align(
      alignment: isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        // Based on who sent the message
        padding: EdgeInsets.only(
          left: isSentByCurrentUser ? 70 : 0,
          right: isSentByCurrentUser ? 0 : 70
        ),
        child: Row(
          mainAxisAlignment: isSentByCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // User icon on the left if not sent by current user
            !isSentByCurrentUser
              ? Icon(Icons.account_circle, color: Colors.black, size: 32)
              : Container(),

            // Message body
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: isSentByCurrentUser ? Colors.blueAccent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getMessageText(context),
                  style: TextStyle(
                    color: isSentByCurrentUser ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            // User icon on the right if sent by current user
            isSentByCurrentUser
              ? Icon(Icons.account_circle, color: Colors.black, size: 32)
              : Container(),
          ],
        ),
      ),
    );
  }

  // Messages with offers and counteroffers
  Widget _buildOfferMessage(BuildContext context, Message message) {
    final bool isSentByCurrentUser = message.sender == context.watch<UserProvider>().loggedInUser;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getMessageText(context),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              if(!isSentByCurrentUser) // Different results for buyer and seller
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ComicSansButton(
                          text: 'Controfferta',
                          height: 40,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => OfferScreen(chat: chat)
                            ));
                          },
                          enabled: message.offerPrice == chat.product.offerPrice && message.offerPrice != null
                            ? true
                            : false
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ComicSansButton(
                          height: 40,
                          text: 'Accetta',
                          onPressed: () {
                            // TODO: Accetta offerta
                          },
                          enabled: message.offerPrice == chat.product.offerPrice && message.offerPrice != null
                            ? true
                            : false
                        ),
                      )
                    ],
                  ),
                )
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptOfferMessage() {
    return Container();
  }

  String _getMessageText(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    if (message.type == MessageType.normal) {
      return message.text!;
    }
    // Message from buyer
    if(message.type == MessageType.offer && message.sender == userProvider.loggedInUser) {
      return "Proposta inviata: ${message.offerPrice}€";
    }
    // Message from seller
    if(message.type == MessageType.offer && message.sender != userProvider.loggedInUser) {
      return "Proposta ricevuta: ${message.offerPrice}€";
    }
    // Message from seller
    if(message.type == MessageType.acceptOffer) {
      return "Proposta accettata";
    }
    return 'errore';
  }
}