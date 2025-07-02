import 'package:comicsans/Components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComicSansAppBar(
        title: 'Benvenuto!',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ComicSansTextInput(
                      title: 'Indirizzo email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
        
                    ComicSansTextInput(
                      title: 'Password',
                      passwordField: true,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        label: Text('Password dimenticata?'),
                        onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
                      ),
                    ),
                    const SizedBox(height: 20),
        
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // evita che si allarghi troppo
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google_logo.png',
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Accedi con Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
        
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Avoid to enlarge too much
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/facebook_logo.png',
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Accedi con Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Non hai un account? ',
                              style: const TextStyle (
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton.icon(
                              label: Text(
                                'Registrati',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              onPressed: () => Navigator.pushNamed(context, '/registration'),
                            ),
                          ]
                        ),
                      ),
        
                      ComicSansButton (
                        text: 'Accedi',
                        onPressed: () {
                          Navigator.pushNamed(context, '/'); // Go to the main screen
                        },
                      ),
                    ]
                  ),
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}