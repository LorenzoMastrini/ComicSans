import 'package:comicsans/Message.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/user.dart';

class Chat {
  List<Message> messages;
  User interlocutor;
  Comic product;
  bool newMessages = false;

  Chat(this.messages, this.interlocutor, this.product, this.newMessages);
}