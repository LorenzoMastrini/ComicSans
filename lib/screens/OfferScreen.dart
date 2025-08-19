import 'package:comicsans/Chat.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/global_constants.dart';
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
    _priceController = TextEditingController(text: ''); // Initialization
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MessagesProvider messageProvider = context.read<MessagesProvider>();

    return Scaffold(
      appBar: _buildAppBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
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
              ComicSansButton(
                onPressed: () {
                  final price = double.tryParse(_priceController.text) ?? 0;
                  // update the offerPrice of the product
                  messageProvider.offer(widget.chat, price, false);
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
    final product = widget.chat.product;
    final username = usernameToDisplay(context, widget.chat);

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(fontSize: 16)
              ),
              Divider(height: 4),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                )
              )
            ]
          ),
          Text(
            '${product.price}€',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            )
          )
        ],
      )
    );
  }
}