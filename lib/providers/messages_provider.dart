import 'package:comicsans/Chat.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';



class MessagesProvider extends ChangeNotifier {
  List<Chat> _allChats = []; // List of all chats
  List<Chat> get chats => List.unmodifiable(_allChats);

  User? _currentUser;
  User? get currentUser => _currentUser;
  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  void initChatsList(List<Chat> chats) {
    _allChats.addAll(chats);
    notifyListeners();
  }

  void markChatAsRead(Chat chat) {
    chat.newMessages = false;
    notifyListeners();
  }

  List<Message> getChatMessages(Chat chat) {
    return chat.messages;
  }

  int getChatLength(Chat chat) {
    return chat.messages.length;
  }

  void sendMessage(Chat chat, String messageText) {
    final newMessage = Message(
      sender: _currentUser!,
      text: messageText,
      date: DateTime.now()
    );
    chat.messages.add(newMessage);
    notifyListeners();
  }

  void offer(Chat chat, double? offerPrice) {
    chat.product.offerPrice = offerPrice;
    final newMessage = Message(
      sender: _currentUser!,
      date: DateTime.now(),
      type: MessageType.offer,
      offerPrice: offerPrice
    );
    chat.messages.add(newMessage);
    notifyListeners();
  }

  void resetInformations() {
    _allChats = [];
    notifyListeners();
  }
}