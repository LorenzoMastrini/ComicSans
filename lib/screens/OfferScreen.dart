import 'package:comicsans/Chat.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class OfferScreen extends StatefulWidget {
  final Chat chat;

  const OfferScreen({super.key, required this.chat});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    double currentPrice = widget.chat.product.price;
    // Initializations of TextEditingController
    _priceController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final MessagesProvider provider = context.read<MessagesProvider>();

    return Scaffold(
      appBar: _buildAppBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ComicSansTextInput(
                      title: 'Prezzo',
                      hintText: 'Nuovo prezzo',
                      labelText: 'Fai un\'offerta appropriata',
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top:28),
                    child: Text(
                      '€',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ]
              ),
              Spacer(),
              ComicSansButton(
                onPressed: () {
                  // update the offerPrice of the product
                  provider.offer(widget.chat, double.tryParse(_priceController.text) ?? 0);
                  Navigator.pop(context);
                },
                text: "Fai un'offerta",
              )
            ]
          ),
        ),
      ),
    );
  }

  // Custom app bar (same as ChatScreen)
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
                widget.chat.interlocutor.username,
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