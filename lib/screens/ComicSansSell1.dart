import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:comicsans/screens/ComicSansSell2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ComicSansSell1 extends StatefulWidget {
  Comic? comicToModify;

  ComicSansSell1({super.key, this.comicToModify});

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

    _titleController = TextEditingController(text: widget.comicToModify?.title ?? '');
    _descriptionController = TextEditingController(text: widget.comicToModify?.description ?? '');
    _priceController = TextEditingController(text: widget.comicToModify?.price.toString() ?? '');
    _conditionsController = TextEditingController(text: widget.comicToModify != null ? conditionsToString(widget.comicToModify?.conditions) : '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<SellInfoProvider>();
      provider.title = widget.comicToModify?.title;
      provider.description = widget.comicToModify?.description;
      provider.price = widget.comicToModify?.price;
      provider.conditions = widget.comicToModify?.conditions;
    });
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
    final provider = context.read<SellInfoProvider>();

    return Scaffold(
      appBar: ComicSansAppBar(
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
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' Informazione obbligatoria'
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Titolo
                  ComicSansTextInput(
                    title: 'Titolo',
                    hintText: 'Inserisci il titolo del fumetto',
                    inputRequired: true,
                    controller: _titleController,
                    onFieldSubmitted: (value) => provider.title = value,
                  ),
                  const SizedBox(height: 20),

                  // Description
                  ComicSansTextInput(
                    title: 'Descrizione',
                    hintText: 'Inserisci la descrizione del fumetto',
                    height: 300,
                    keyboardType: TextInputType.multiline,
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
                          hintText: 'Inserisci un prezzo appropriato',
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
                    title: 'Condizioni ',
                    options: Conditions.values.map((condition) => conditionsToString(condition)).toList(),
                    inputRequired: true,
                    controller: _conditionsController,
                    onChanged: (newValue) {
                      provider.conditions = stringToConditions(newValue);
                      if (_conditionsController.text != (newValue ?? '')) {
                        _conditionsController.text = newValue ?? '';
                      }
                      setState(() {});
                    },
                    // Selected value from the comic i'm modifying (if any) or from provider
                    selectedValue: conditionsToString(widget.comicToModify != null ? widget.comicToModify!.conditions : provider.conditions)
                  ),
                  const SizedBox(height: bottomSpaceForButton),
                ]
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: ComicSansButton(
                  text: 'Continua',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ComicSansSell2(comicToModify: widget.comicToModify)),
                      );
                    }
                  },
                ),
              )
            ]
          ),
        )
      )
    );
  }
}