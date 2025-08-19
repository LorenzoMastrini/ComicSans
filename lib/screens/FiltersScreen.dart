import 'package:comicsans/screens/SearchResults.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansCheckbox.dart';
import 'package:comicsans/components/ComicSansDropdown.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/components/ComicSansToggle.dart';
import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/providers/comics_provider.dart';
import '../comic.dart';
import '../providers/comics_provider.dart';
import '../providers/user_provider.dart';

class FiltersScreen extends StatefulWidget{
  final String query;
  FiltersScreen({super.key, required this.query});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final List<TextEditingController> _authorControllers = [];
  late TextEditingController _languageController;
  late TextEditingController _italianPublisherController;
  late TextEditingController _originalPublisherController;
  late TextEditingController _collanaController;
  late TextEditingController _countryController;
  late TextEditingController _fromPriceController;
  late TextEditingController _toPriceController;
  late TextEditingController _fromPublicationYearController;
  late TextEditingController _toPublicationYearController;
  late TextEditingController _fromEditionYearController;
  late TextEditingController _toEditionYearController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ComicsProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      /*if (provider.authors.isEmpty) {
        provider.addAuthor('');
      }*/

      _authorControllers.addAll(
          provider.authors.map((text) => TextEditingController(text: text)));

      _syncAuthors(provider); // anche questa è sicura qui
    });

    // Initializations of TextEditingController controllers
    _languageController = TextEditingController(text: provider.language ?? '');
    _italianPublisherController = TextEditingController(text: provider.italianPublisher ?? '');
    _originalPublisherController = TextEditingController(text: provider.originalPublisher ?? '');
    _collanaController = TextEditingController(text: provider.series ?? '');
    _countryController = TextEditingController(text: provider.country ?? '');
    _fromPriceController = TextEditingController(text: provider.fromPrice?.toString() ?? '');
    _toPriceController = TextEditingController(text: provider.toPrice?.toString() ?? '');
    _fromPublicationYearController = TextEditingController(text: provider.fromPublicationYear?.toString() ?? '');
    _toPublicationYearController = TextEditingController(text: provider.toPublicationYear?.toString() ?? '');
    _fromEditionYearController = TextEditingController(text: provider.fromEditionYear?.toString() ?? '');
    _toEditionYearController = TextEditingController(text: provider.toEditionYear?.toString() ?? '');

  }

  @override
  void dispose() {
    for (var c in _authorControllers) {
      c.dispose();
    }
    _languageController.dispose();
    _italianPublisherController.dispose();
    _originalPublisherController.dispose();
    _collanaController.dispose();
    _countryController.dispose();
    _fromPriceController.dispose();
    _toPriceController.dispose();
    _fromPublicationYearController.dispose();
    _toPublicationYearController.dispose();
    _fromEditionYearController.dispose();
    _toEditionYearController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<ComicsProvider>();
    final authors = provider.authors;

    if (!listEquals(authors, _authorControllers.map((c) => c.text).toList())) {
      for (final c in _authorControllers) {
        c.dispose();
      }
      _authorControllers.clear();
      _authorControllers.addAll(authors.map((a) => TextEditingController(text: a)));
    }
  }

  // Add new author
  void _addAuthor() {
    context.read<ComicsProvider>().addAuthor('');
    setState(() => _authorControllers.add(TextEditingController()));
  }

  // Remove existing author
  void _removeAuthor(int index) {
    final provider = context.read<ComicsProvider>();

    if (index < 0 || index >= _authorControllers.length) return; // Check the index

    final removedController = _authorControllers.removeAt(index); // Remove controller from the list
    removedController.dispose();
    provider.removeAuthor(index); // Update provider

    if (_authorControllers.isEmpty) {
      provider.addAuthor(''); // Add a new empty author if list is empty
      _authorControllers.add(TextEditingController());
    }

    setState(() {}); // Force the rebuild after safe update
  }

  @override
  Widget build(BuildContext context) {
    const double btnBottomPadding = 15; // Bottom padding for the button
    const double btnHeight = 60;
    const double bottomSpaceForButton = btnHeight + btnBottomPadding * 5; // Space for the ListView to avoid content under the button
    final providerWatch = context.watch<ComicsProvider>();
    final providerRead = context.read<ComicsProvider>();

    return Scaffold(
        appBar: ComicSansAppBar(
            showBackButton: true,
            actionType: AppBarActionType.reset,
            onResetPressed: _resetFilters
        ),
        body: Form(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
              child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: ListView(
                            children: [
                              Text(
                                  'Prezzo',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ComicSansTextInput(
                                        title: 'Da',
                                        keyboardType: TextInputType.number,
                                        controller: _fromPriceController,
                                        onChanged: (value) => providerRead.fromPrice = double.tryParse(value)
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 150,
                                      child: ComicSansTextInput(
                                          title: 'A',
                                          controller: _toPriceController,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) => providerRead.toPrice = double.tryParse(value)
                                      ),
                                    ),
                                  ]
                              ),
                              SizedBox(height: 20),
                        
                              // Authors
                              Text(
                                  'Autori',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(), // Disable scrolling of inner ListView
                                itemCount: _authorControllers.length,
                                itemBuilder: (_, i) => Row (
                                  children: [
                                    Expanded(
                                      child: ComicSansTextInput(
                                        title: '',
                                        hintText: 'Sceneggiatore, disegnatore',
                                        labelText: '',
                                        controller: _authorControllers[i],
                                        onChanged: (val) => providerWatch.updateAuthor(i, val),
                                      ),
                                    ),
                                    if (_authorControllers.length > 1)
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline),
                                        onPressed: () => _removeAuthor(i),
                                      ),
                                  ],
                                ),
                              ),
                              // Button to add a new author
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text('Aggiungi autore'),
                                  onPressed: _addAuthor,
                                ),
                              ),
                              SizedBox(height: 20),
                        
                              //Conditions
                              ComicSansCheckbox(
                                  title: 'Condizioni',
                                  options: Conditions.values.map((cond) => {
                                    'title': conditionsToString(cond),
                                    'value': providerWatch.conditions.contains(cond), // Provider initial state
                                  }).toList(),
                                  onChanged: (title, value) =>
                                      context.read<ComicsProvider>().updateConditions(stringToConditions(title), value)
                              ),
                              SizedBox(height: 20),
                        
                              // Genres
                              ComicSansCheckbox(
                                  title: 'Genere',
                                  options: Genre.values.map((genre) => {
                                    'title': genreToString(genre),
                                    'value': providerWatch.genre.contains(genre), // Provider initial state
                                  }).toList(),
                                  onChanged: (title, value) =>
                                      context.read<ComicsProvider>().updateGenre(stringToGenre(title), value)
                              ),
                              SizedBox(height: 20),
                        
                              // Publication year
                              Text(
                                  'Anno di pubblicazione',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ComicSansTextInput(
                                        title: 'Da',
                                        controller: _fromPublicationYearController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => providerRead.fromPublicationYear = int.tryParse(value)
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 150,
                                      child: ComicSansTextInput(
                                        title: 'A',
                                        controller: _toPublicationYearController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => providerRead.toPublicationYear = int.tryParse(value)
                                      ),
                                    ),
                                  ]
                              ),
                              SizedBox(height: 20),
                        
                              ComicSansDropdown(
                                  title: 'Lingua',
                                  options: availableLanguages,
                                  controller: _languageController,
                                  onChanged: (newValue) => providerRead.language = newValue,
                                  value: providerWatch.language
                              ),
                              SizedBox(height: 20),
                        
                              // Italian publisher
                              ComicSansTextInput(
                                title: 'Editore italiano',
                                hintText: 'Editore italiano',
                                labelText: 'Inserisci l\'editore italiano del fumetto',
                                controller: _italianPublisherController,
                                onChanged: (value) => providerRead.italianPublisher = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Original publisher
                              ComicSansTextInput(
                                title: 'Editore paese di origine',
                                hintText: 'Editore paese di origine',
                                labelText: 'Inserisci l\'editore originale del fumetto',
                                controller: _originalPublisherController,
                                onChanged: (value) => providerRead.originalPublisher = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Series
                              ComicSansTextInput(
                                title: 'Collana',
                                hintText: 'Collana',
                                labelText: 'Inserisci la collana di appartenenza del fumetto',
                                controller: _collanaController,
                                onChanged: (value) => providerRead.series = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Country of origin
                              ComicSansTextInput(
                                title: 'Paese di origine',
                                hintText: 'Paese di origine',
                                labelText: 'Inserisci il paese di origine del fumetto',
                                controller: _countryController,
                                onChanged: (value) => providerRead.country = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Variant
                              ComicSansToggle(
                                title: 'Variant',
                                value: providerWatch.variant ?? false,
                                onChanged: (value) => providerRead.variant = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Bookbinding
                              ComicSansCheckbox(
                                  title: 'Rilegatura',
                                  options: Binding.values.map((binding) => {
                                    'title': bindingToString(binding),
                                    'value': providerWatch.binding.contains(binding), // Provider initial state
                                  }).toList(),
                                  onChanged: (title, value) =>
                                      context.read<ComicsProvider>().updateBinding(stringToBinding(title), value)
                              ),
                              SizedBox(height: 20),
                        
                              // Graded
                              ComicSansToggle(
                                title: 'Gradato',
                                value: providerWatch.graded ?? false,
                                onChanged: (value) => providerRead.graded = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Signed
                              ComicSansToggle(
                                title: 'Firmato',
                                value: providerWatch.signed ?? false,
                                onChanged: (value) => providerRead.signed = value,
                              ),
                              SizedBox(height: 20),
                        
                              // Edition year
                              Text(
                                  'Anno edizione',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: ComicSansTextInput(
                                        title: 'Da',
                                        keyboardType: TextInputType.number,
                                        controller: _fromEditionYearController,
                                        onChanged: (value) => providerRead.fromEditionYear = int.tryParse(value)
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 150,
                                      child: ComicSansTextInput(
                                        title: 'A',
                                        controller: _toEditionYearController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => providerRead.toEditionYear = int.tryParse(value)
                                      ),
                                    ),
                                  ]
                              ),
                              SizedBox(height: 20),
                            ]
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: ComicSansButton (
                        text: 'Applica',
                        onPressed: () {
                          List<Comic> filtered = providerRead.filterPurchasableComics(context.read<UserProvider>().loggedInUser, widget.query);

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SearchResults(comicsResults: filtered, query: widget.query)
                           ));
                        },
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }

  void _resetFilters(){
    final provider = context.read<ComicsProvider>();
    provider.resetInformations();

    setState(() {
      for (var c in _authorControllers) c.clear();
      _languageController.clear();
      _italianPublisherController.clear();
      _originalPublisherController.clear();
      _collanaController.clear();
      _countryController.clear();
      _fromPriceController.clear();
      _toPriceController.clear();
      _fromPublicationYearController.clear();
      _toPublicationYearController.clear();
      _fromEditionYearController.clear();
      _toEditionYearController.clear();
    });
  }

  void _syncAuthors(ComicsProvider provider) {
    final authors = provider.authors;

    // If the number of controllers and authors differ, resync
    if (_authorControllers.length != authors.length) {
      // Update the controllers to match authors safely
      while (_authorControllers.length > authors.length) {
        _authorControllers.removeLast().dispose();
      }

      while (_authorControllers.length < authors.length) {
        _authorControllers.add(TextEditingController(text: authors[_authorControllers.length]));
      }
    }

    // Update the text if needed
    for (int i = 0; i < _authorControllers.length; i++) {
      if (_authorControllers[i].text != authors[i]) {
        _authorControllers[i].text = authors[i];
      }
    }
  }

}
