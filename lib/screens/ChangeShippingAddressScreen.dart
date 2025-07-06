import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/address.dart';
import '../Components/ComicSansButton.dart';
import '../components/ComicSansTextInput.dart';
import '../user.dart';

class ChangeShippingAddressScreen extends StatefulWidget{
  User user;
  ChangeShippingAddressScreen({super.key, required this.user});

  @override
  State<ChangeShippingAddressScreen> createState() => _ChangeShippingAddressScreenState();
}

class _ChangeShippingAddressScreenState extends State<ChangeShippingAddressScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _countryController;
  late TextEditingController _addressController;
  late TextEditingController _capController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.addr?.name);
    _lastNameController = TextEditingController(text: widget.user.addr?.lastName);
    _countryController = TextEditingController(text: widget.user.addr?.country);
    _addressController = TextEditingController(text: widget.user.addr?.address);
    _capController = TextEditingController(text: widget.user.addr?.cap.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _countryController.dispose();
    _addressController.dispose();
    _capController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void updateAddressData() {
      final newAddres = Address(
          name: _nameController.text,
          lastName:  _lastNameController.text,
          country:  _countryController.text,
          address: _addressController.text,
          cap: int.parse(_capController.text),
      );

      widget.user.addr = newAddres;
      Navigator.pop(context, true);
    }

    return Scaffold(
      appBar: ComicSansAppBar(
        title: "Cambia indirizzo",
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
                    title: 'Nome',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Cognome',
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Paese',
                    keyboardType: TextInputType.emailAddress,
                    controller: _countryController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Indirizzo',
                    controller: _addressController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'CAP',
                    controller: _capController,
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ComicSansButton (
                      text: 'Conferma',
                      onPressed: updateAddressData,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}