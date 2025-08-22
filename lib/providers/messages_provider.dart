import 'package:comicsans/Chat.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MessagesProvider extends ChangeNotifier {
  List<Chat> _allChats = []; // List of all chats
  List<Chat> get allChats => List.unmodifiable(_allChats);

  bool _initDone = false;
  void initChatsList(List<Chat> chats) {
    if(!_initDone) {
      _allChats.addAll(chats);
      _initDone = true;
    }
    notifyListeners();
  }

  List<Chat> getUserChats(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    // Filter only the chats in which the current user is involved
    return _allChats.where((chat) => chat.seller == userProvider.loggedInUser || chat.buyer == userProvider.loggedInUser).toList();
  }

  void createNewChat(Chat newChat) {
    _allChats.add(newChat);
    notifyListeners();
  }

  void markChatAsRead(Chat chat) {
    if (chat.newMessages) {
      chat.newMessages = false;
      notifyListeners();
    }
  }

  List<Message> getChatMessages(Chat chat) => chat.messages;

  int getChatLength(Chat chat) => chat.messages.length;

  void sendMessage(BuildContext context, Chat chat, String messageText) {
    final userProvider = context.read<UserProvider>();

    // Create a new conversation if there is a new message and the chat does not exists already
    if (chat.messages.isEmpty && !_allChats.contains(chat)) {
      createNewChat(chat);
    }

    final newMessage = Message(
        sender: userProvider.loggedInUser!,
        text: messageText,
        date: DateTime.now()
    );

    chat.messages.add(newMessage);
    notifyListeners();
  }

  void offer(BuildContext context, Chat chat, double? offerPrice, bool accepted) {
    final userProvider = context.read<UserProvider>();
    chat.currentOfferPrice = offerPrice;

    if (!accepted) {
      final newMessage = Message(
        sender: userProvider.loggedInUser!,
        date: DateTime.now(),
        type: MessageType.offer,
      );

      // Create a new conversation if there is a new message
      if (chat.messages.isEmpty && !_allChats.contains(chat)) {
        createNewChat(chat);
      }
      chat.messages.add(newMessage);
    }
    notifyListeners();
  }

  void acceptOffer(BuildContext context, Chat chat) {
    final userProvider = context.read<UserProvider>();

    final newMessage = Message(
        sender: userProvider.loggedInUser!,
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