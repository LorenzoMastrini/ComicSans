import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/SampleData.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/Components/ComicSansButton.dart';
import 'package:comicsans/providers/comics_provider.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comicsans/user.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final comicsProvider = context.read<ComicsProvider>();
      final messagesProvider = context.read<MessagesProvider>();
      comicsProvider.initComicsList(SampleData.allComics); // Initialize provider with sample data
      messagesProvider.initChatsList(SampleData.allChats);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(UserProvider userProvider){
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    User? matchedUser;
    for(var user in SampleData.allUsers){
      if(user.email == email && user.password == password){
        matchedUser = user;
        break;
      }
    }

    if(matchedUser != null) {
      userProvider.loggedInUser = matchedUser;
      Navigator.pushReplacementNamed(context, '/'); // Go to the main screen
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Email o password errati!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK")
            )
          ]
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();

    return Scaffold(
      appBar: ComicSansAppBar(
        title: 'Benvenuto!',
        style: TextStyle(fontWeight: FontWeight.bold,),
        showBackButton: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ComicSansTextInput(
                            title: 'Indirizzo email',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          ComicSansTextInput(
                            title: 'Password',
                            passwordField: true,
                            controller: _passwordController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              child: const Text(
                                'Password dimenticata?',
                                style: TextStyle(fontSize: 14, color: Color(0xFF669bbc)),
                              ),
                              onPressed: () {
                                // Handle password reset logic here
                              },
                            ),
                          ),

                          const SizedBox(height: 20),
                          // Sign In with Google
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            onPressed: () {
                              userProvider.loggedInUser = SampleData.user1;
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/google_logo.png', height: 24),
                                const SizedBox(width: 12),
                                const Text('Accedi con Google', style: TextStyle(color: Colors.black)),
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
                            onPressed: () {
                              userProvider.loggedInUser = SampleData.user2;
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/facebook_logo.png', height: 24),
                                const SizedBox(width: 12),
                                const Text('Accedi con Facebook', style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Non hai un account? ',
                                  style: TextStyle(fontSize: 14, color: Color(0xFF669bbc)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(context, '/registration'),
                                  child: const Text(
                                    'Registrati',
                                    style: TextStyle(fontSize: 14, color: Color(0xFF669bbc)),
                                  ),
                                ),
                              ],
                            ),
                            ComicSansButton(
                              text: 'Accedi',
                              onPressed: () => login(userProvider),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}