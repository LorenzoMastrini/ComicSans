import 'package:comicsans/Chat.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/OfferScreen.dart';
import 'package:comicsans/screens/PurchaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MessageComponent extends StatefulWidget {
  final Chat chat;
  final Message message;

  const MessageComponent({super.key, required this.chat, required this.message});

  @override
  State<MessageComponent> createState() => _MessageComponentState();
}

class _MessageComponentState extends State<MessageComponent> {
  bool _areButtonsEnabled = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.message.type) {
      case MessageType.normal:
        return _buildNormalMessage(context, widget.message);
      case MessageType.offer:
        return _buildOfferMessage(context);
      case MessageType.acceptOffer:
        return _buildAcceptOfferMessage(context, widget.message);
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
  Widget _buildOfferMessage(BuildContext context) {
    final userProviderWatch = context.watch<UserProvider>();
    final bool isSentByCurrentUser = widget.message.sender == userProviderWatch.loggedInUser;
    final messageProviderRead = context.read<MessagesProvider>();

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
                            _disableButtons();
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => OfferScreen(chat: widget.chat)
                            ));
                          },
                          enabled: widget.chat.currentOfferPrice != null
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ComicSansButton(
                          height: 40,
                          text: 'Accetta',
                          onPressed: () {
                            _disableButtons();
                            messageProviderRead.acceptOffer(context, widget.chat);
                          },
                          enabled: widget.chat.currentOfferPrice != null
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

  Widget _buildAcceptOfferMessage(BuildContext context, Message message) {
    final userProviderWatch = context.watch<UserProvider>();
    final comicsProvider = context.watch<ComicsProvider>();
    final bool isSentByCurrentUser = message.sender == userProviderWatch.loggedInUser;

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
                          height: 40,
                          text: 'Acquista',
                          onPressed: () {
                            _disableButtons();
                            widget.chat.product.offerPrice = widget.chat.currentOfferPrice; // Set the final offer price
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PurchaseScreen(comic: widget.chat.product)
                            ));
                          },
                          enabled: widget.chat.currentOfferPrice != null && comicsProvider.allComics.contains(widget.chat.product)
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

  String _getMessageText(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    if (widget.message.type == MessageType.normal) {
      return widget.message.text!;
    }
    // Offer from buyer
    if(widget.message.type == MessageType.offer && widget.message.sender == userProvider.loggedInUser) {
      return "Proposta inviata: ${widget.chat.currentOfferPrice}€";
    }
    // Offer from seller
    if(widget.message.type == MessageType.offer && widget.message.sender != userProvider.loggedInUser) {
      return "Proposta ricevuta: ${widget.chat.currentOfferPrice}€";
    }
    // Offer accepted (by either buyer or seller)
    if(widget.message.type == MessageType.acceptOffer) {
      return "Proposta accettata";
    }
    return 'errore';
  }

  void _disableButtons() {
    setState(() {
      _areButtonsEnabled = false;
    });
  }
}