import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';


enum MessageType {normal, offer, acceptOffer}

class Chat {
  List<Message> messages;
  User interlocutor;
  Comic product;
  bool newMessages = false;

  Chat(this.messages, this.interlocutor, this.product, this.newMessages);
}



class Message {
  final String? text;
  final DateTime date;
  final User sender;
  final MessageType type;
  final double? offerPrice;

  Message({
    required this.sender,
    this.text,
    required this.date,
    this.type = MessageType.normal,
    this.offerPrice
  });
}