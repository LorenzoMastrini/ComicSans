import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/screens/ComicSansButton.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // For form validation
    String? _currentPassword;

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
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Cognome',
                    inputRequired: true,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Indirizzo email',
                    keyboardType: TextInputType.emailAddress,
                    inputRequired: true,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Password',
                    passwordField: true,
                    inputRequired: true,
                    onChanged: (value) {
                      _currentPassword = value;
                    },
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); // Go to the main screen
            }
          },
        ),
      ),
    );
  }
}