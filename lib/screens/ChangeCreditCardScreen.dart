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
  bool correctCvv = true;
  bool correctNumber = true;
  bool correctHolder = true;
  bool correctExpiration = true;

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
      setState(() {
        correctNumber = _numberController.text.length == 16;
        correctCvv = _cvvController.text.length == 3;
        correctExpiration = _expirationController.text.isNotEmpty;
        correctHolder = _holderController.text.isNotEmpty;
      });

      if(correctNumber && correctCvv && correctExpiration && correctHolder){
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
                  Column(
                      children:<Widget>[
                        ComicSansTextInput(
                          title: 'Titolare della carta',
                          controller: _holderController,
                        ),
                        if(correctHolder != true)
                          Text("Inserisci un nome", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary))
                      ]
                  ),
                  const SizedBox(height: 10),

                  Column(
                      children:<Widget>[
                        ComicSansTextInput(
                          title: 'Numero della carta',
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                        ),
                        if(correctNumber != true)
                          Text("Numero non valido", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary))
                      ]
                  ),
                  const SizedBox(height: 10),
                  Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Column(
                              children:<Widget>[
                                ComicSansTextInput(
                                  title: 'Scadenza',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _expirationController,
                                ),
                                if(correctExpiration != true)
                                  Text("Data non valida", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary))
                              ]
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                            children:<Widget>[
                              SizedBox(
                                width: 150,
                                child: ComicSansTextInput(
                                  title: 'CVV',
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              if(correctCvv != true)
                                Text("CVV non valido", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary))
                            ]
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