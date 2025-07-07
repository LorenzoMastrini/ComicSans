import 'package:comicsans/providers/user_provider.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansButton.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:provider/provider.dart';



class ChangeCreditCardScreen extends StatefulWidget{
  const ChangeCreditCardScreen({super.key});

  @override
  State<ChangeCreditCardScreen> createState() => _ChangeCreditCardScreenState();
}



class _ChangeCreditCardScreenState extends State<ChangeCreditCardScreen> {
  late TextEditingController _holderController;
  late TextEditingController _numberController;
  late TextEditingController _expirationController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _holderController = TextEditingController();
    _numberController = TextEditingController();
    _expirationController = TextEditingController();
    _cvvController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      CreditCard? card = userProvider.loggedInUser!.card;

      setState(() {
        _holderController = TextEditingController(text: card?.holder);
        _numberController = TextEditingController(text: card?.number.toString());
        _expirationController = TextEditingController(text: card?.expiration);
        _cvvController = TextEditingController(text: card?.cvv.toString());
      });
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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final userProviderRead = context.read<UserProvider>();

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