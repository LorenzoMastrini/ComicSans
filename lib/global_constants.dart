import 'package:comicsans/Chat.dart';
import 'package:comicsans/providers/messages_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

enum Conditions { daEdicola, ottime, buone, moltoUsato }

String conditionsToString(Conditions? condition) {
  switch (condition) {
    case Conditions.daEdicola:
      return 'Da edicola';
    case Conditions.ottime:
      return 'Ottime';
    case Conditions.buone:
      return 'Buone';
    case Conditions.moltoUsato:
      return 'Molto usato';
    default:
      return "";
  }
}

Conditions? stringToConditions(String? stringCondition) {
  switch (stringCondition) {
    case "Da edicola":
      return Conditions.daEdicola;
    case "Ottime":
      return Conditions.ottime;
    case "Buone":
      return Conditions.buone;
    case "Molto usato":
      return Conditions.moltoUsato;
    default:
      return null; // Error
  }
}

enum Genre { avventura, azione, crime, drammatico, fantasy, horror, poliziesco, romantico, sciFi, soprannaturale, supereroi, thriller, umoristico, altro }

String genreToString(Genre genre) {
  switch (genre) {
    case Genre.avventura:
      return 'Avventura';
    case Genre.azione:
      return 'Azione';
    case Genre.crime:
      return 'Crime';
    case Genre.drammatico:
      return 'Drammatico';
    case Genre.fantasy:
      return 'Fantasy';
    case Genre.horror:
      return 'Horror';
    case Genre.poliziesco:
      return 'Poliziesco';
    case Genre.romantico:
      return 'Romantico';
    case Genre.sciFi:
      return 'Sci-Fi';
    case Genre.soprannaturale:
      return 'Soprannaturale';
    case Genre.supereroi:
      return 'Supereroi';
    case Genre.thriller:
      return 'Thriller';
    case Genre.umoristico:
      return 'Umoristico';
    case Genre.altro:
      return 'Altro';
  }
}

Genre stringToGenre(String? stringGenre) {
  switch (stringGenre) {
    case "Avventura":
      return Genre.avventura;
    case "Azione":
      return Genre.azione;
    case "Crime":
      return Genre.crime;
    case "Drammatico":
      return Genre.drammatico;
    case "Fantasy":
      return Genre.fantasy;
    case "Horror":
      return Genre.horror;
    case "Poliziesco":
      return Genre.poliziesco;
    case "Romantico":
      return Genre.romantico;
    case "Sci-Fi":
      return Genre.sciFi;
    case "Soprannaturale":
      return Genre.soprannaturale;
    case "Supereroi":
      return Genre.supereroi;
    case "Thriller":
      return Genre.thriller;
    case "Umoristico":
      return Genre.umoristico;
    case "Altro":
      return Genre.altro;
    default:
      return Genre.altro; // Error
  }
}

// Bookbinding
enum Binding { brossurato, cartonato, spillato, altro }

String bindingToString(Binding? binding) {
  switch (binding) {
    case Binding.brossurato:
      return 'Brossurato';
    case Binding.cartonato:
      return 'Cartonato';
    case Binding.spillato:
      return 'Spillato';
    case Binding.altro:
      return 'Altro';
    default:
      return 'Error'; // Error
  }
}

Binding? stringToBinding(String? bindingString) {
  switch (bindingString) {
    case "Brossurato":
      return Binding.brossurato;
    case "Cartonato":
      return Binding.cartonato;
    case "Spillato":
      return Binding.spillato;
    case "Altro":
      return Binding.altro;
    default:
      return null; // Error
  }
}


const List<String> availableLanguages = [
  'Francese',
  'Giapponese',
  'Inglese',
  'Italiano',
  'Spagnolo',
  'Tedesco',
  'Altro',
];

enum Shipping { home, retirePoint }
enum PaymentMethod { creditCard, payPal }
enum Gender { maschio, femmina, altro }

// To distinguish the two kinds of search bars (the one in the homepage and the one in the favorite page)
enum SearchContent { purchasableComics, favoriteComics }

String usernameToDisplay(BuildContext context, Chat chat) {
  return chat.seller.username == context.read<MessagesProvider>().currentUser!.username
      ? chat.buyer.username
      : chat.seller.username;
}