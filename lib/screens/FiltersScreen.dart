import 'package:flutter/material.dart';
import 'package:comicsans/GlobalConstants.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansCheckbox.dart';
import 'package:comicsans/components/ComicSansDropdown.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/components/ComicSansRadioButtons.dart';
import 'package:comicsans/components/ComicSansToggle.dart';
import 'package:comicsans/providers/SellInfoProvider.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget{
  FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
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
  late TextEditingController _priceStartController;
  late TextEditingController _priceEndController;

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
    _isbnController = TextEditingController(text: provider.isbn ?? '');
    _bookbindingsController = TextEditingController(text: provider.bookbinding ?? '');
    _priceStartController = TextEditingController();
    _priceEndController = TextEditingController();

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
    final sellInfo = context.watch<SellInfoProvider>();
    final provider = Provider.of<SellInfoProvider>(context, listen: false);

    return Scaffold(
        appBar: const ComicSansAppBar(
            showBackButton: true,
            title: ''
        ),
        body: Form(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
              child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView(
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _priceStartController,
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: ComicSansTextInput(
                                      title: 'A',
                                      controller: _priceEndController,
                                      keyboardType: TextInputType.number,
                                      validator: (value){
                                      }
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
                                    onChanged: (val) => sellInfo.updateAuthor(i, val),
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
                              title: 'Condizioni',
                              options: GlobalConstants.availableConditions.map((title) => {
                                'title': title, // Provider initial state
                              }).toList(),
                              onChanged: (title, value) =>
                                  context.read<SellInfoProvider>().updateCondition(title, value)
                          ),
                          SizedBox(height: 20),

                          // Genres
                          ComicSansCheckbox(
                              title: 'Genere',
                              options: GlobalConstants.availableGenreTitles.map((title) => {
                                'title': title,
                                'value': sellInfo.genres.contains(title), // Provider initial state
                              }).toList(),
                              onChanged: (title, value) =>
                                  context.read<SellInfoProvider>().updateGenre(title, value)
                          ),
                          SizedBox(height: 20),

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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _priceStartController,
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: ComicSansTextInput(
                                      title: 'A',
                                      controller: _priceEndController,
                                      keyboardType: TextInputType.number,
                                      validator: (value){
                                      }
                                  ),
                                ),
                              ]
                          ),

                          ComicSansDropdown(
                              title: 'Lingua',
                              options: GlobalConstants.availableLanguages,
                              controller: _languageController,
                              onChanged: (newValue) => provider.language = newValue,
                              value: sellInfo.language
                          ),
                          SizedBox(height: 20),

                          // Italian publisher
                          ComicSansTextInput(
                            title: 'Editore italiano',
                            hintText: 'Editore italiano',
                            labelText: 'Inserisci l\'editore italiano del fumetto',
                            controller: _italianPublisherController,
                            onFieldSubmitted: (value) => provider.italianPublisher = value,
                          ),
                          SizedBox(height: 20),

                          // Original publisher
                          ComicSansTextInput(
                            title: 'Editore paese di origine',
                            hintText: 'Editore paese di origine',
                            labelText: 'Inserisci l\'editore originale del fumetto',
                            controller: _originalPublisherController,
                            onFieldSubmitted: (value) => provider.originalPublisher = value,
                          ),
                          SizedBox(height: 20),

                          // Collana
                          ComicSansTextInput(
                            title: 'Collana',
                            hintText: 'Collana',
                            labelText: 'Inserisci la collana di appartenenza del fumetto',
                            controller: _collanaController,
                            onFieldSubmitted: (value) => provider.series = value,
                          ),
                          SizedBox(height: 20),

                          // Country of origin
                          ComicSansTextInput(
                            title: 'Paese di origine',
                            hintText: 'Paese di origine',
                            labelText: 'Inserisci il paese di origine del fumetto',
                            controller: _countryController,
                            onFieldSubmitted: (value) => provider.country = value,
                          ),
                          SizedBox(height: 20),

                          // Variant
                          ComicSansToggle(
                            title: 'Variant',
                            value: sellInfo.variant ?? false,
                            onChanged: (value) => provider.variant = value,
                          ),
                          SizedBox(height: 20),

                          // Bookbinding
                          ComicSansCheckbox(
                              title: 'Rilegatura',
                              options: GlobalConstants.availableBookbindings.map((title) => {
                                'title': title, // Provider initial state
                              }).toList(),
                              onChanged: (title, value) =>
                                  context.read<SellInfoProvider>().updateBookbinding(title, value)
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 20),

                          // Graded
                          ComicSansToggle(
                            title: 'Gradato',
                            value: sellInfo.graded ?? false,
                            onChanged: (value) => provider.graded = value,
                          ),
                          SizedBox(height: 20),

                          // Signed
                          ComicSansToggle(
                            title: 'Firmato',
                            value: sellInfo.signed ?? false,
                            onChanged: (value) => provider.signed = value,
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
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _priceStartController,
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 150,
                                  child: ComicSansTextInput(
                                      title: 'A',
                                      controller: _priceEndController,
                                      keyboardType: TextInputType.number,
                                      validator: (value){
                                      }
                                  ),
                                ),
                              ]
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
                          Navigator.pushNamed(context, '/'); // return to the main screen
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