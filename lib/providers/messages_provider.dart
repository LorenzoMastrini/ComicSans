import 'package:comicsans/Chat.dart';
import 'package:comicsans/comic.dart';
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

  Chat createNewChat(Chat newChat) {
    _allChats.add(newChat);
    notifyListeners();
    return newChat;
  }

  void markChatAsRead(Chat chat) {
    if (chat.newMessages) {
      chat.newMessages = false;
      notifyListeners();
    }
  }

  List<Message> getChatMessages(Chat chat) => chat.messages;

  int getChatLength(Chat chat) => chat.messages.length;

  void sendMessage(Chat chat, String messageText) {
    // Create a new conversation if there is a new message and the chat does not exists already
    if (chat.messages.isEmpty && !_allChats.contains(chat)) {
      createNewChat(chat);
    }

    final newMessage = Message(
        sender: _currentUser!,
        text: messageText,
        date: DateTime.now()
    );

    chat.messages.add(newMessage);
    notifyListeners();
  }

  void offer(Chat chat, double? offerPrice, bool accepted) {
    chat.currentOfferPrice = offerPrice;

    if (!accepted) {
      final newMessage = Message(
        sender: _currentUser!,
        date: DateTime.now(),
        type: MessageType.offer,
      );

      // Create a new conversation if there is a new message
      if(chat.messages.isEmpty) {
        createNewChat(chat);
      }
      chat.messages.add(newMessage);
    }
    notifyListeners();
  }

  void acceptOffer(Chat chat) {
      final newMessage = Message(
          sender: _currentUser!,
          date: DateTime.now(),
          type: MessageType.acceptOffer,
      );
      chat.messages.add(newMessage);
    notifyListeners();
  }

  void declineOffer(Chat chat) {
    chat.currentOfferPrice = null;
    notifyListeners();
  }

  void resetInformations() {
    _allChats = [];
    notifyListeners();
  }
}