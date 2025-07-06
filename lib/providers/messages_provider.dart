import 'package:comicsans/Chat.dart';
import 'package:flutter/material.dart';



class MessagesProvider extends ChangeNotifier {
  // List of all chats
  final List<Chat> _allChats = [];
  List<Chat> get chats => List.unmodifiable(_allChats);

  void initChatsList(List<Chat> chats) {
    _allChats.addAll(chats);
    notifyListeners();
  }
}