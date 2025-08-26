import 'package:comicsans/Chat.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/components/MessageComponent.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/screens/OfferScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// Must be StatefulWidget to use the custom app bar
class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final MessagesProvider messagesProvider = Provider.of<MessagesProvider>(context, listen: false);
      // Mark chat as read as soon the user enters the chat page
      messagesProvider.markChatAsRead(widget.chat);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String messageText = _controller.text.trim();

    if (messageText.isNotEmpty) {
      final MessagesProvider messagesProviderRead = context.read<MessagesProvider>();
      messagesProviderRead.sendMessage(context, widget.chat, messageText);

      // Clear the text field after sending the message
      _controller.clear();
      _focusNode.unfocus(); // Dismiss the keyboard after sending the message
    }
  }

  @override
  Widget build(BuildContext context) {
    final MessagesProvider messagesProviderWatch = context.watch<MessagesProvider>();
    final UserProvider userProviderWatch = context.watch<UserProvider>();

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messagesProviderWatch.getChatLength(widget.chat),
              itemBuilder: (context, index) => MessageComponent(
                chat: widget.chat,
                message: messagesProviderWatch.getChatMessages(widget.chat)[index]
              ),
            )
          ),
          SizedBox(
            // Show the offer button only if the current user is the buyer
            child: widget.chat.buyer == userProviderWatch.loggedInUser
              ? ComicSansButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => OfferScreen(chat: widget.chat)
                  ));
                },
                text: "Fai un'offerta",
                height: 50,
                width: 200,
              )
              : null,
          ),
          _buildMessageInput()
        ]
      ),
      resizeToAvoidBottomInset: true, // Ensures the body resizes when the keyboard is shown
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Icon for attachment (optional)
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              // TODO: attach files to chat(?)
            },
          ),
          // Text field to type the message
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Scrivi un messaggio...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          // Send button
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                usernameToDisplay(context, widget.chat),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )
              ),
              Divider(height: 4,),
              Text(
                widget.chat.product.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                )
              )
            ]
          ),
          Text(
            '${widget.chat.product.price.toString()}€',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500
            )
          )
        ],
      )
    );
  }
}