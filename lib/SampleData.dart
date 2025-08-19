import 'package:comicsans/Chat.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/review.dart';
import 'package:comicsans/user.dart';



class SampleData{
  static late User user1, user2;
  static late Comic comic1, comic2, comic3, comic4;

  static void init() {
    user1 = User(
      id: 1,
      username: "Lemo5£",
      name: "Lemorzo",
      lastName: "Da Palermo",
      email: "prova1@prova.com",
      password: "1234",
      imagePath: "",
      gender: Gender.maschio,
      birthday: "5/7/2001",
      address: Address(
        name: "Lemorzo",
        lastName: "Da Palermo",
        country: "Italia",
        address: "Via Oregon 2",
        cap: 06055
      ),
      card: CreditCard(
        holder: "Lemorzo Da Palermo",
        number: 1234123412341234,
        expiration: "5/06",
        cvv: 123
      ),
      rating: 3,
      favouriteComics: [],
      followedUsers: [],
      comicsSale: [],
      reviews: [],
      sellings: [],
      purchases: [],
      connectedAccount: false,
    );
  user2 = User(
    id: 2,
    username: "Giobo",
    name: "Giovanni",
    lastName: "Carlini",
    email: "prova2@prova.com",
    password: "1234",
    imagePath: "",
    gender: Gender.maschio,
    birthday: "5/7/2001",
    reviews: [],
    address: Address(
      name: "Giovanni",
      lastName: "Carlini",
      country: "Italia",
      address: "Via Consolato 2",
      cap: 06055
    ),
    card: CreditCard(
      holder: "Giovanni Carlini",
      number: 2345234523452345,
      expiration: "5/07",
      cvv: 234
    ),
    rating: 5,
    favouriteComics: [],
    followedUsers: [],
    comicsSale: [],
    sellings: [],
    purchases: [],
    connectedAccount: false
  );


  comic1 = Comic(
    id: 1,
    seller: user1,
    title: "Spider-Man 2",
    description: "Spider-Man 2 variant",
    price: 5,
    conditions: Conditions.daEdicola,
    otherImagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman-cover.jpg',
    authors: ["Brian Michael Bendis","Mark Bagley"],
    genre: [Genre.supereroi],
    publicationYear: 2004,
    language: "Italiano",
    italianPublisher: "Panini Comics",
    originalPublisher: "Marvel Comics",
    series: "",
    country: "USA",
    variant: true,
    graded: false,
    signed: false,
    editionYear: 2004,
    isbn: 3456789012,
  );
  comic2 = Comic(
    id: 2,
    seller: user1,
    title: "Spider-Man 3",
    description: "Spider-Man 3 variant",
    price: 5,
    conditions: Conditions.daEdicola,
    otherImagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman-cover.jpg',
    authors: ["Brian Michael Bendis","Mark Bagley"],
    genre: [Genre.supereroi],
    publicationYear: 2004,
    language: "Italiano",
    italianPublisher: "Panini Comics",
    originalPublisher: "Marvel Comics",
    series: "",
    country: "USA",
    variant: true,
    graded: false,
    signed: false,
    editionYear: 2004,
    isbn: 2345678901,
  );
  comic3 = Comic(
    id: 3,
    seller: user2,
    title: "Batman 4",
    description: "Batman 4",
    price: 5,
    conditions: Conditions.buone,
    otherImagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman-cover.jpg',
    authors: ["Chip Zdarsky, Carmine Di Giandomenico"],
    genre: [Genre.supereroi],
    publicationYear: 2010,
    language: "Italiano",
    italianPublisher: "Panini Comics",
    originalPublisher: "",
    series: "",
    country: "USA",
    variant: false,
    graded: false,
    signed: false,
    editionYear: 2010,
    isbn: 0,
  );
  comic4 = Comic(
      id: 4,
      seller: user2,
      title: "Batman 5",
      description: "Batman 5",
      price: 3,
      conditions: Conditions.daEdicola,
      otherImagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
      coverPath: 'assets/comic_cover/spiderman-cover.jpg',
      authors: ["Brian Michael Bendis","Mark Bagley"],
      genre: [Genre.supereroi],
      publicationYear: 2004,
      language: "Italiano",
      italianPublisher: "Panini Comics",
      originalPublisher: "Marvel Comics",
      series: "",
      country: "USA",
      variant: true,
      graded: false,
      signed: false,
      editionYear: 2004,
      isbn: 1234567890,
    );

    user1.comicsSale = [comic1, comic2];
    user2.comicsSale = [comic3, comic4];
    user1.reviews = [Review(stars: 5, description: "Descrizione della recensione", user: user2)];
    user2.reviews = [Review(stars: 5, description: "Descrizione della recensione", user: user1)];
  }

  static List<Comic> allComics = [SampleData.comic1, SampleData.comic2, SampleData.comic3, SampleData.comic4];
  static List<User> allUsers = [user1, user2,];


  // Simulated chat 1
  static Message c1_msg1 = Message(
    sender: user2,
    text: "Ciao. A quanto lo vendi il numero 3 di Spider-Man?",
    date: DateTime(2025, 7, 2)
  );
  static Message c1_msg2 = Message(
    sender: user1,
    text: "Salve. Il prezzo pubblicato è 3€ ma posso fare uno sconto",
    date: DateTime(2025, 7, 3)
  );
  static Chat chat1 = Chat([c1_msg1, c1_msg2], user2, user1, comic2, true);

  // Simulated chat 2
  static Message c2_msg1 = Message(
    sender: user2,
    text:  "Ciao. Voglio tutto a 1€",
    date: DateTime(2025, 6, 29)
  );
  static Message c2_msg2 = Message(
    sender: user1,
    text: "Ok va bene",
    date: DateTime(2025, 6, 30)
  );
  static Chat chat2 = Chat([c2_msg1, c2_msg2], user2, user1, comic2, false);

  static List<Chat> allChats = [chat1, chat2];
}