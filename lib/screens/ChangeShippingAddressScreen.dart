import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansButton.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class ChangeShippingAddressScreen extends StatefulWidget{
  const ChangeShippingAddressScreen({super.key});

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

    // Initialize controllers
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _countryController = TextEditingController();
    _addressController = TextEditingController();
    _capController = TextEditingController();

    // Safe access to provider without triggering rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      Address? addr = userProvider.loggedInUser!.address;
      setState(() {
        _nameController = TextEditingController(text: addr?.name);
        _lastNameController = TextEditingController(text: addr?.lastName);
        _countryController = TextEditingController(text: addr?.country);
        _addressController = TextEditingController(text: addr?.address);
        _capController = TextEditingController(text: addr?.cap.toString());
      });
    });
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
    final formKey = GlobalKey<FormState>();
    final userProviderRead = context.read<UserProvider>();

    void updateAddressData() {
      final newAddress = Address(
          name: _nameController.text,
          lastName:  _lastNameController.text,
          country:  _countryController.text,
          address: _addressController.text,
          cap: int.parse(_capController.text),
      );

      userProviderRead.updateAddress(newAddress);
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
            key: formKey,
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
                    keyboardType: TextInputType.number,
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
          onPressed: updateAddressData,
        ),
      ),
    );
  }
}