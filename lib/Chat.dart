import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';


enum MessageType {normal, offer, acceptOffer}

class Chat {
  List<Message> messages;
  User buyer;
  User seller;
  Comic product;
  bool newMessages = false;
  double? currentOfferPrice;

  Chat(this.messages, this.buyer, this.seller, this.product, this.newMessages);
}



class Message {
  final String? text;
  final DateTime date;
  final User sender;
  final MessageType type;

  Message({
    required this.sender,
    this.text,
    required this.date,
    this.type = MessageType.normal,
  });
}