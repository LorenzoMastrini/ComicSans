import 'package:comicsans/Chat.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:flutter/material.dart';



class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComicSansAppBar(
        title: widget.chat.interlocutor.username,
      ),
      body: Container()
    );
  }
}