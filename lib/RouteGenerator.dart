import 'package:comicsans/Chat.dart';
import 'package:comicsans/MainScreen.dart';
import 'package:comicsans/screens/ChatScreen.dart';
import 'package:comicsans/screens/Login.dart';
import 'package:comicsans/screens/Registration.dart';
import 'package:comicsans/user.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments; // Arguments passed in the call to Navigator.pushNamed

    switch(routeSettings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/forgot_password':
        if(args is User) {
          return MaterialPageRoute(builder: (_) => MainScreen(user: args));
        }
        return _errorRoute();
      case '/registration':
        return MaterialPageRoute(builder: (_) => const Registration());
      case '/chat':
        if (args is Chat) {
          return MaterialPageRoute(builder: (_) => ChatScreen(chat: args));
        } else {
          return _errorRoute();
        }
      case '/':
        if(args is User) {
          return MaterialPageRoute(builder: (_) => MainScreen(user: args));
        } // Main screen with the bottom bar
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  // Route not found
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error Route'),
        ),
        body: const Center(
          child: Text('ERROR ROUTE'),
        ),
      );
    }
    );
  }
}