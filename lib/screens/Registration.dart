import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/SampleData.dart';

import '../user.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    // For form validation
    String? _currentPassword;

    @override
    void dispose() {
      _nameController.dispose();
      _lastNameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
      super.dispose();
    }

    void registerUser() {
      if (_formKey.currentState!.validate()) {
        final name = _nameController.text.trim();
        final lastName = _lastNameController.text.trim();
        final email = _emailController.text.trim();
        final password = _passwordController.text;
        if(SampleData.allUsers.any((user) => user.email == email)){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  content: Text("Questa email è già stata utilizzata!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK")
                    )
                  ]
              )
          );
          return;
        }

        final newUser = User(
          id: SampleData.allUsers.length + 1,
          username: "$name$lastName",
          name: name,
          lastName: lastName,
          email: email,
          password: password,
          imagePath: "",
          gend: Gender.Altro,
          birthday: "",
          addr: null,
          card: null,
          rating: 0,
          favouriteComics: [],
          followedUsers: [],
          comicsSale: [],
          reviews: [],
          sellings: [],
          purchases: [],
          connectedAccount: false,
        );

        SampleData.allUsers.add(newUser);

        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Go to the main screen
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Registrati a Comic Sans'),
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
                    inputRequired: true,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Cognome',
                    inputRequired: true,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Indirizzo email',
                    keyboardType: TextInputType.emailAddress,
                    inputRequired: true,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Password',
                    passwordField: true,
                    inputRequired: true,
                    onChanged: (value) {
                      _currentPassword = value;
                    },
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Conferma password',
                    passwordField: true,
                    inputRequired: true,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty) {
                        return 'Campo obbligatorio';
                      }
                      if (value != _currentPassword) {
                        return 'Le password non corrispondono';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),

      // To maintain the button under the keyboard when it opens
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ComicSansButton (
          text: 'Registrati',
          onPressed: registerUser,
        ),
      ),
    );
  }
}