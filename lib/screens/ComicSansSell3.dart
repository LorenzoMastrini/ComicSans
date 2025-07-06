import 'dart:io';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansCheckbox.dart';
import 'package:comicsans/components/ComicSansDropdown.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/components/ComicSansToggle.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/sell_informations_provider.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ComicSansSell3 extends StatefulWidget {
  const ComicSansSell3({super.key});

  @override
  State<ComicSansSell3> createState() => _ComicSansSell3State();
}



class _ComicSansSell3State extends State<ComicSansSell3> {
  final List<TextEditingController> _authorControllers = [];
  late TextEditingController _publicationYearController;
  late TextEditingController _languageController;
  late TextEditingController _italianPublisherController;
  late TextEditingController _originalPublisherController;
  late TextEditingController _collanaController;
  late TextEditingController _countryController;
  late TextEditingController _editionYearController;
  late TextEditingController _isbnController;
  late TextEditingController _bookbindingsController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SellInfoProvider>();

    if(provider.authors.isEmpty) {
      provider.addAuthor('');
    }
    _authorControllers.addAll(
        provider.authors.map((text) => TextEditingController(text: text)));

    // Initializations of TextEditingController controllers
    _publicationYearController = TextEditingController(text: provider.publicationYear?.toString() ?? '');
    _languageController = TextEditingController(text: provider.language ?? '');
    _italianPublisherController = TextEditingController(text: provider.italianPublisher ?? '');
    _originalPublisherController = TextEditingController(text: provider.originalPublisher ?? '');
    _collanaController = TextEditingController(text: provider.series ?? '');
    _countryController = TextEditingController(text: provider.country ?? '');
    _editionYearController = TextEditingController(text: provider.editionYear?.toString() ?? '');
    _isbnController = TextEditingController(text: provider.isbn?.toString() ?? '');
    _bookbindingsController = TextEditingController(text: provider.bookbinding?.toString() ?? '');

    _syncAuthors(provider);
  }

  @override
  void dispose() {
    for (var c in _authorControllers) {
      c.dispose();
    }
    _publicationYearController.dispose();
    _languageController.dispose();
    _italianPublisherController.dispose();
    _originalPublisherController.dispose();
    _collanaController.dispose();
    _countryController.dispose();
    _editionYearController.dispose();
    _bookbindingsController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<SellInfoProvider>();
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
    context.read<SellInfoProvider>().addAuthor('');
    setState(() => _authorControllers.add(TextEditingController()));
  }

  // Remove existing author
  void _removeAuthor(int index) {
    final provider = context.read<SellInfoProvider>();

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
    final providerWatch = context.watch<SellInfoProvider>();
    final providerRead = context.read<SellInfoProvider>();

    return Scaffold(
      appBar: const ComicSansAppBar(
          title: '3/3: Dettagli',
          showBackButton: true,
          showCloseButton: true,
          actionType: AppBarActionType.close
      ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  children: [
                    Text('Le seguenti informazioni non sono obbligatorie'),
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

                    // Genres
                    ComicSansCheckbox(
                      title: 'Genere',
                      options: Genre.values.map((genre) => {
                        'title': genreToString(genre),
                        'value': providerWatch.genre.contains(genre), // Provider initial state
                      }).toList(),
                      onChanged: (title, value) =>
                        context.read<SellInfoProvider>().updateGenre(stringToGenre(title), value)
                    ),
                    SizedBox(height: 20),

                    // Publication year
                    ComicSansTextInput(
                      title: 'Anno di pubblicazione',
                      hintText: 'Anno di pubblicazione',
                      labelText: 'Inserisci la data di pubblicazione dell\'opera',
                      keyboardType: TextInputType.number,
                      controller: _publicationYearController,
                      onFieldSubmitted: (value) => providerRead.publicationYear = int.tryParse(value)
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
                      onFieldSubmitted: (value) => providerRead.italianPublisher = value,
                    ),
                    SizedBox(height: 20),

                    // Original publisher
                    ComicSansTextInput(
                      title: 'Editore paese di origine',
                      hintText: 'Editore paese di origine',
                      labelText: 'Inserisci l\'editore originale del fumetto',
                      controller: _originalPublisherController,
                      onFieldSubmitted: (value) => providerRead.originalPublisher = value,
                    ),
                    SizedBox(height: 20),

                    // Series
                    ComicSansTextInput(
                      title: 'Collana',
                      hintText: 'Collana',
                      labelText: 'Inserisci la collana di appartenenza del fumetto',
                      controller: _collanaController,
                      onFieldSubmitted: (value) => providerRead.series = value,
                    ),
                    SizedBox(height: 20),

                    // Country of origin
                    ComicSansTextInput(
                      title: 'Paese di origine',
                      hintText: 'Paese di origine',
                      labelText: 'Inserisci il paese di origine del fumetto',
                      controller: _countryController,
                      onFieldSubmitted: (value) => providerRead.country = value,
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
                    ComicSansRadioButtons(
                      title: 'Rilegatura',
                      options: Binding.values.map((binding) => bindingToString(binding)).toList(),
                      controller: _bookbindingsController,
                      onChanged: (newValue) {
                        providerRead.bookbinding = stringToBinding(newValue);
                        if (_bookbindingsController.text != (newValue ?? '')) {
                           _bookbindingsController.text = newValue ?? '';
                        }
                      },
                      selectedValue: bindingToString(providerWatch.bookbinding) // Selected value from provider
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
                    ComicSansTextInput(
                      title: 'Anno edizione',
                      hintText: 'Anno edizione',
                      labelText: 'Inserisci la data di uscita dell\'edizione',
                      keyboardType: TextInputType.number,
                      controller: _editionYearController,
                      onFieldSubmitted: (value) => providerRead.editionYear = int.tryParse(value),
                    ),
                    SizedBox(height: 20),

                    // ISBN
                    ComicSansTextInput(
                      title: 'ISBN',
                      hintText: 'ISBN',
                      labelText: 'Inserisci l\'ISBN del volume',
                      controller: _isbnController,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) => providerRead.isbn = int.tryParse(value),
                    ),
                    SizedBox(height: bottomSpaceForButton)
                  ]
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: ComicSansButton (
                    text: 'Pubblica',
                    onPressed: () {
                      final ComicsProvider comicsProvider = context.read<ComicsProvider>();
                      final UserProvider userProvider = context.read<UserProvider>();

                      // create Comic object with the informations from provider
                      Comic newComic = providerRead.createComic();
                      comicsProvider.addComic(newComic); // Add the comic to the global list
                      userProvider.addComicToLibrary(newComic); // Add comic to the user's library
                      providerRead.resetInformations(); // Reset the provider (clear fields)
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', // return to the main screen
                        (route) => false, // remove from the stack all the visited routes
                      );
                    },
                  ),
                )
              ]
            ),
          )
        )
    );
  }

  void _syncAuthors(SellInfoProvider provider) {
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