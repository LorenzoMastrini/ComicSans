import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Components/ComicSansButton.dart';
import '../CreditCard.dart';
import '../components/ComicSansAppBar.dart';
import '../components/ComicSansTextInput.dart';
import '../user.dart';

class CreditCardAccountSettingsScreen extends StatefulWidget{
  User user;
  CreditCardAccountSettingsScreen({super.key, required this.user});

  @override
  State<CreditCardAccountSettingsScreen> createState() => _CreditCardAccountSettingsScreenState();
}

class _CreditCardAccountSettingsScreenState extends State<CreditCardAccountSettingsScreen> {
  late TextEditingController _holderController;
  late TextEditingController _numberController;
  late TextEditingController _expirationController;
  late TextEditingController _cvvController;
  late bool isConnected;

  @override
  void initState() {
    super.initState();
    _holderController = TextEditingController(text: widget.user.card?.holder);
    _numberController = TextEditingController(text: widget.user.card?.number.toString());
    _expirationController = TextEditingController(text: widget.user.card?.expiration);
    _cvvController = TextEditingController(text: widget.user.card?.cvv.toString());
    isConnected = widget.user.connectedAccount;
  }

  @override
  void dispose() {
    _holderController.dispose();
    _numberController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void toggleAccount(){
    setState(() {
      if(isConnected){
        widget.user.connectedAccount = false;
      }
      else{
        widget.user.connectedAccount = true;
      }
      isConnected = !isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void updateCreditCardData() {
      if(_formKey.currentState!.validate()){
        final newCard = CreditCard(
          holder: _holderController.text,
          number: int.parse(_numberController.text),
          expiration: _expirationController.text,
          cvv: int.parse(_cvvController.text),
        );

        widget.user.card = newCard;
        Navigator.pop(context, true);
      }
    }

    return Scaffold(
      appBar: ComicSansAppBar(
        title: "Dati della carta",
        showBackButton: true,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Form (
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ComicSansTextInput(
                    title: 'Titolare della carta',
                    controller: _holderController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                      title: 'Numero della carta',
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value?.length != 16)
                          return 'Numero della carta non valido';

                        return null;
                      }
                  ),
                  const SizedBox(height: 10),

                  Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: ComicSansTextInput(
                            title: 'Scadenza',
                            keyboardType: TextInputType.emailAddress,
                            controller: _expirationController,
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 150,
                          child: ComicSansTextInput(
                              title: 'CVV',
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if(value?.length != 3)
                                  return 'CVV non valido';

                                return null;
                              }
                          ),
                        ),
                      ]
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text("PayPal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      Icon(FontAwesomeIcons.paypal, color: Colors.black),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          toggleAccount();
                        },
                        child: Text(
                            isConnected ? 'Scollega' : 'Collega',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: isConnected ? 16 : 16,
                                fontWeight: FontWeight.normal)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ComicSansButton (
          text: 'Conferma',
          onPressed: updateCreditCardData,
        ),
      ),
    );
  }
}