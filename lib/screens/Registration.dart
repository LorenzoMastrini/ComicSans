import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/SampleData.dart';
import 'package:comicsans/user.dart';



class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    // For form validation
    String? currentPassword;

    @override
    void dispose() {
      nameController.dispose();
      lastNameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      super.dispose();
    }

    void registerUser() {
      if (formKey.currentState!.validate()) {
        final name = nameController.text.trim();
        final lastName = lastNameController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text;
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
          gender: Gender.altro,
          birthday: "",
          address: null,
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
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ComicSansTextInput(
                    title: 'Nome',
                    inputRequired: true,
                    controller: nameController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Cognome',
                    inputRequired: true,
                    controller: lastNameController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Indirizzo email',
                    keyboardType: TextInputType.emailAddress,
                    inputRequired: true,
                    controller: emailController,
                  ),
                  const SizedBox(height: 10),

                  ComicSansTextInput(
                    title: 'Password',
                    passwordField: true,
                    inputRequired: true,
                    onChanged: (value) {
                      currentPassword = value;
                    },
                    controller: passwordController,
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
                      if (value != currentPassword) {
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