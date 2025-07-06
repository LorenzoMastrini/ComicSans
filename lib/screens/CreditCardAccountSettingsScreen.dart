import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comicsans/components/ComicSansButton.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:provider/provider.dart';



class CreditCardAccountSettingsScreen extends StatefulWidget{
  const CreditCardAccountSettingsScreen({super.key});

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
    // Safe access to provider without triggering rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: true);
      CreditCard? card = userProvider.loggedInUser!.card;
      _holderController = TextEditingController(text: card?.holder);
      _numberController = TextEditingController(text: card?.number.toString());
      _expirationController = TextEditingController(text: card?.expiration);
      _cvvController = TextEditingController(text: card?.cvv.toString());
      isConnected = userProvider.loggedInUser!.connectedAccount;
    });
  }

  @override
  void dispose() {
    _holderController.dispose();
    _numberController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void toggleAccount() {
    UserProvider userProviderRead = context.read<UserProvider>();

    setState(() {
      if(isConnected){
        userProviderRead.loggedInUser!.connectedAccount = false;
      }
      else{
        userProviderRead.loggedInUser!.connectedAccount = true;
      }
      isConnected = !isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final UserProvider userProviderRead = context.read<UserProvider>();

    void updateCreditCardData() {
      if(formKey.currentState!.validate()){
        final newCard = CreditCard(
          holder: _holderController.text,
          number: int.parse(_numberController.text),
          expiration: _expirationController.text,
          cvv: int.parse(_cvvController.text),
        );

        userProviderRead.loggedInUser!.card = newCard;
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
            key: formKey,
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
                      if(value?.length != 16) {
                        return 'Numero della carta non valido';
                      }

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
                            if(value?.length != 3) {
                              return 'CVV non valido';
                            }

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
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: Text(
                          isConnected ? 'Scollega' : 'Collega',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: isConnected ? 16 : 16,
                            fontWeight: FontWeight.normal)),
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