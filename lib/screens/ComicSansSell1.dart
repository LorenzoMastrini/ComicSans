import 'package:comicsans/GlobalContants.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/providers/SellInfoProvider.dart';
import 'package:comicsans/screens/ComicSansSell2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComicSansSell1 extends StatefulWidget {
  const ComicSansSell1({super.key});

  @override
  State<ComicSansSell1> createState() => _ComicSansSell1State();
}



class _ComicSansSell1State extends State<ComicSansSell1> {
  final _formKey = GlobalKey<FormState>(); // For form validation
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _conditionsController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SellInfoProvider>();

    // Initializations of TextEditingController controllers
    _titleController = TextEditingController(text: provider.title ?? '');
    _descriptionController = TextEditingController(text: provider.description ?? '');
    _priceController = TextEditingController(text: provider.price?.toString() ?? '');
    _conditionsController = TextEditingController(text: provider.isbn ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _conditionsController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const double btnBottomPadding = 15; // Bottom padding for the button
    const double btnHeight = 60;
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 5;
    final provider = Provider.of<SellInfoProvider>(context, listen: false);

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: "1/3: Informazioni base",
          showBackButton: false,
          showCloseButton: true,
          actionType: AppBarActionType.close
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Informazione obbligatoria'
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Titolo
                  ComicSansTextInput(
                    title: 'Titolo',
                    hintText: 'Titolo',
                    labelText: 'Inserisci il titolo del fumetto',
                    inputRequired: true,
                    controller: _titleController,
                    onFieldSubmitted: (value) => provider.title = value,
                  ),
                  const SizedBox(height: 20),

                  // Description
                  ComicSansTextInput(
                    title: 'Descrizione',
                    hintText: 'Descrizione',
                    labelText: 'Inserisci la descrizione del fumetto',
                      inputRequired: true,
                    controller: _descriptionController,
                    onFieldSubmitted: (value) => provider.description = value,
                  ),
                  const SizedBox(height: 20),

                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ComicSansTextInput(
                          title: 'Prezzo',
                          hintText: 'Prezzo',
                          labelText: 'Inserisci un prezzo appropriato',
                          inputRequired: true,
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          onFieldSubmitted: (value) => provider.price = double.tryParse(value) ?? 0
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 10),
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
                  const SizedBox(height: 20),

                  // Conditions
                  ComicSansRadioButtons(
                    title: 'Condizioni',
                    options: GlobalConstants.availableConditions,
                    inputRequired: true,
                    controller: _conditionsController,
                    onChanged: (newValue) {
                      provider.conditions = newValue;
                      if (_conditionsController.text != (newValue ?? '')) {
                        _conditionsController.text = newValue ?? '';
                      }
                      setState(() {});
                    },
                    selectedValue: context.watch<SellInfoProvider>().conditions // Selected value from provider
                  ),
                  const SizedBox(height: bottomSpaceForButton),
                ]
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ComicSansSell2()),
                      );
                    }
                  },
                  child: const Text('Continua')
                ),
              )
            ]
          ),
        )
      )
    );
  }
}