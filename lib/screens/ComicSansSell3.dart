import 'package:comicsans/SampleData.dart';
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
  Comic? comicToModify;

  ComicSansSell3({super.key, this.comicToModify});

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
  late TextEditingController _bookbindingController;
  List<String> _suggestedAuthors = [];
  late int _controllerIndex;
  late double _position;
  final ScrollController _scrollController = ScrollController();
  List<GlobalKey> _authorTextFieldKeys = [];
  final double _maxPositionY = 500;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SellInfoProvider>();

    _scrollController.addListener(() {
      setState(() {}); // Forza un rebuild per correggere la posizione durante lo scroll
    });

    if(provider.authors.isEmpty) {
      provider.addAuthor('');
    }
    _authorControllers.addAll(provider.authors.map((text) => TextEditingController(text: text)));

    // Initializations of TextEditingController controllers
    _publicationYearController = TextEditingController(text: widget.comicToModify?.publicationYear?.toString() ?? '');
    _languageController = TextEditingController(text: widget.comicToModify?.language ?? '');
    _italianPublisherController = TextEditingController(text: widget.comicToModify?.italianPublisher ?? '');
    _originalPublisherController = TextEditingController(text: widget.comicToModify?.originalPublisher ?? '');
    _collanaController = TextEditingController(text: widget.comicToModify?.series ?? '');
    _countryController = TextEditingController(text: widget.comicToModify?.country ?? '');
    _editionYearController = TextEditingController(text: widget.comicToModify?.editionYear?.toString() ?? '');
    _isbnController = TextEditingController(text: widget.comicToModify?.isbn?.toString() ?? '');
    _bookbindingController = TextEditingController(text: widget.comicToModify != null ? bindingToString(widget.comicToModify?.bookbinding) : '');

    _syncAuthors(provider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.publicationYear = widget.comicToModify?.publicationYear;
      provider.language = widget.comicToModify?.language;
      provider.italianPublisher = widget.comicToModify?.italianPublisher;
      provider.originalPublisher = widget.comicToModify?.originalPublisher;
      provider.series = widget.comicToModify?.series;
      provider.country = widget.comicToModify?.country;
      provider.editionYear = widget.comicToModify?.editionYear;
      provider.isbn = widget.comicToModify?.isbn;
      provider.bookbinding = widget.comicToModify?.bookbinding;
      provider.variant = widget.comicToModify?.variant;
      provider.graded = widget.comicToModify?.graded;
      provider.signed = widget.comicToModify?.signed;
      provider.genre = widget.comicToModify?.genre ?? [];
      provider.authors = widget.comicToModify?.authors ?? [];
    });

    _authorTextFieldKeys = List.generate(_authorControllers.length, (_) => GlobalKey<FormState>());
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
    _bookbindingController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  void _filterAuthors(String query) {
    final suggestions = SampleData.allAuthors.where((author) {
      return author.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _suggestedAuthors = suggestions;
    });
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
      _authorTextFieldKeys.clear();
      _authorControllers.addAll(authors.map((a) => TextEditingController(text: a)));
      _authorTextFieldKeys.addAll(List.generate(authors.length, (_) => GlobalKey<FormState>()));
    }
  }

  // Add new author
  void _addAuthor() {
    context.read<SellInfoProvider>().addAuthor('');
    setState(() {
      _authorControllers.add(TextEditingController());
      _authorTextFieldKeys.add(GlobalKey());
      _controllerIndex = _authorControllers.length - 1;
    });
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

    setState(() {
      _controllerIndex--;
    }); // Force the rebuild after safe update
  }

  void _getWidgetPosition(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      Offset position = renderBox.localToGlobal(Offset.zero);
      // Find position only if widget is visible
      if (position.dy > 0 && position.dy < _maxPositionY) {
        setState(() {
          _position = position.dy;
        });
      }
    } else {
      print("Errore nel calcolare la posizione: il RenderObject è null");
    }
  }

  Widget _buildSuggestions() {
    if (_suggestedAuthors.isNotEmpty && _authorControllers.isNotEmpty) {
      return Positioned(
        left: 8,
        right: 60,
        top: _position - 12,
        child: Material(
          elevation: 5,
          color: Colors.white,
          child: SizedBox(
            height: 50.toDouble() * (_suggestedAuthors.length > 5 ? 5 : _suggestedAuthors.length), // Adjust the height for the dropdown
            child: ListView.builder(
              itemCount: _suggestedAuthors.length > 5
                  ? 5
                  : _suggestedAuthors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  minTileHeight: 50,
                  title: Text(_suggestedAuthors[index], style: TextStyle(fontSize: 16),),
                  onTap: () {
                    // User selects an author
                    _authorControllers[_controllerIndex].text = _suggestedAuthors[index];
                    setState(() {
                      _suggestedAuthors = []; // Hide list after selection
                    });
                  },
                );
              },
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
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
                  controller: _scrollController,
                  children: [
                    Text('Informazioni non obbligatorie'),
                    SizedBox(height: 20),

                    // Authors
                    Text(
                      'Autori',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Disable scrolling of inner ListView
                      itemCount: _authorControllers.length,
                      itemBuilder: (_, i) => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ComicSansTextInput(
                                  key: _authorTextFieldKeys[i],
                                  title: '',
                                  hintText: 'Sceneggiatore, disegnatore',
                                  controller: _authorControllers[i],
                                  onChanged: (val) {
                                    providerWatch.updateAuthor(i, val);
                                    _filterAuthors(val);
                                  }
                                ),
                              ),
                              if (_authorControllers.length > 1)
                                Padding(
                                  padding: EdgeInsetsGeometry.only(top: 23),
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () => _removeAuthor(i),
                                  ),
                                ),
                            ],
                          ),
                          Builder(
                            builder: (context) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final currentContext = _authorTextFieldKeys[i].currentContext;

                                if (currentContext != null) {
                                  _getWidgetPosition(currentContext);
                                } else {
                                  print("Errore: currentContext è null per l'autore con indice $i");
                                }
                              });
                              return SizedBox(); // Return an empty widget to trigger the call
                            },
                          )
                        ],
                      ),
                    ),
                    // Button to add a new author
                    Align(
                      alignment: Alignment.centerLeft,
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
                      hintText: 'Inserisci la data di uscita',
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
                      hintText: 'Inserisci l\'editore italiano',
                      controller: _italianPublisherController,
                      onFieldSubmitted: (value) => providerRead.italianPublisher = value,
                    ),
                    SizedBox(height: 20),

                    // Original publisher
                    ComicSansTextInput(
                      title: 'Editore paese di origine',
                      hintText: 'Inserisci l\'editore originale',
                      controller: _originalPublisherController,
                      onFieldSubmitted: (value) => providerRead.originalPublisher = value,
                    ),
                    SizedBox(height: 20),

                    // Series
                    ComicSansTextInput(
                      title: 'Collana',
                      hintText: 'Inserisci la collana/serie',
                      controller: _collanaController,
                      onFieldSubmitted: (value) => providerRead.series = value,
                    ),
                    SizedBox(height: 20),

                    // Country of origin
                    ComicSansTextInput(
                      title: 'Paese di origine',
                      hintText: 'Inserisci il paese di origine',
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
                      controller: _bookbindingController,
                      onChanged: (newValue) {
                        providerRead.bookbinding = stringToBinding(newValue);
                        if (_bookbindingController.text != (newValue ?? '')) {
                          _bookbindingController.text = newValue ?? '';
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
                      hintText: 'Inserisci la data di uscita dell\'edizione',
                      keyboardType: TextInputType.number,
                      controller: _editionYearController,
                      onFieldSubmitted: (value) => providerRead.editionYear = int.tryParse(value),
                    ),
                    SizedBox(height: 20),

                    // ISBN
                    ComicSansTextInput(
                      title: 'ISBN',
                      hintText: 'Inserisci l\'ISBN del volume',
                      controller: _isbnController,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) => providerRead.isbn = int.tryParse(value),
                    ),
                    SizedBox(height: bottomSpaceForButton)
                  ]
                ),

                _buildSuggestions(),

                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: ComicSansButton (
                    text: widget.comicToModify == null ? 'Pubblica' : 'Modifica',
                    onPressed: () {
                      final ComicsProvider comicsProvider = context.read<ComicsProvider>();
                      final UserProvider userProvider = context.read<UserProvider>();

                      if(widget.comicToModify == null) {
                        // create Comic object with the informations from provider
                        Comic newComic = providerRead.createComic(context);
                        comicsProvider.addComic(newComic); // Add the comic to the global list
                        userProvider.addComicToLibrary(newComic); // Add comic to the user's library
                        providerRead.resetInformations(); // Reset the provider (clear fields)
                        int count = 0; // Counter of removed pages
                        // Go back until reaching the vendor screen
                        Navigator.of(context).popUntil((route) {
                          count++;
                          return count > 3; // When count > 3, stop popping pages
                        });

                        Navigator.of(context).pushNamed('/user_vendor_screen');
                      } else {
                        providerRead.updateComic(context, widget.comicToModify!);
                        providerRead.resetInformations(); // Reset the provider (clear fields)

                        int count = 0; // Counter of removed pages
                        // Go back until reaching the vendor screen
                        Navigator.of(context).popUntil((route) {
                          count++;
                          return count > 3; // When count > 3, stop popping pages
                        });

                        Navigator.of(context).pushReplacementNamed('/user_vendor_screen');
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

  void _syncAuthors(SellInfoProvider provider) {
    final authors = provider.authors;

    // Update the controllers to match authors safely
    while (_authorControllers.length > authors.length) {
      _authorControllers.removeLast().dispose();
      _authorTextFieldKeys.removeLast();
    }

    while (_authorControllers.length < authors.length) {
      _authorControllers.add(TextEditingController(text: authors[_authorControllers.length]));
      _authorTextFieldKeys.add(GlobalKey());
    }

    // Update the text if needed
    for (int i = 0; i < _authorControllers.length; i++) {
      if (_authorControllers[i].text != authors[i]) {
        _authorControllers[i].text = authors[i];
      }
    }

    _controllerIndex =  authors.length - 1;
  }
}