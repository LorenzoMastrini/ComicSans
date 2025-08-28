import 'package:comicsans/Chat.dart';
import 'package:comicsans/comic.dart';
import 'package:comicsans/global_constants.dart';
import 'package:comicsans/review.dart';
import 'package:comicsans/user.dart';



class SampleData{
  static late User user1, user2, user3, user4, user5;
  static late Comic comic1, comic2, comic3, comic4, comic5, comic6, comic7, comic8, comic9, comic10, comic11, comic12, comic13, comic14, comic15;

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
  user3 = User(
    id: 3,
    username: "FraK_92",
    name: "Francesco",
    lastName: "Rossi",
    email: "prova3@prova.com",
    password: "abcd",
    imagePath: "",
    gender: Gender.maschio,
    birthday: "12/11/1992",
    address: Address(
      name: "Francesco",
      lastName: "Rossi",
      country: "Italia",
      address: "Corso Italia 45",
      cap: 10121,
    ),
    card: CreditCard(
      holder: "Francesco Rossi",
      number: 4321432143214321,
      expiration: "11/27",
      cvv: 456,
    ),
    rating: 4,
    favouriteComics: [],
    followedUsers: [],
    comicsSale: [],
    reviews: [],
    sellings: [],
    purchases: [],
    connectedAccount: true,
  );
  user4 = User(
    id: 4,
    username: "SimoL_88",
    name: "Simona",
    lastName: "Lombardi",
    email: "prova4@prova.com",
    password: "pass88",
    imagePath: "",
    gender: Gender.femmina,
    birthday: "3/4/1988",
    address: Address(
      name: "Simona",
      lastName: "Lombardi",
      country: "Italia",
      address: "Via Firenze 12",
      cap: 50123,
    ),
    card: CreditCard(
      holder: "Simona Lombardi",
      number: 5678567856785678,
      expiration: "8/25",
      cvv: 789,
    ),
    rating: 5,
    favouriteComics: [],
    followedUsers: [],
    comicsSale: [],
    reviews: [],
    sellings: [],
    purchases: [],
    connectedAccount: false,
  );
  user5 = User(
    id: 5,
    username: "Ale_Manga",
    name: "Alessandro",
    lastName: "Verdi",
    email: "prova5@prova.com",
    password: "manga2025",
    imagePath: "",
    gender: Gender.maschio,
    birthday: "20/9/1995",
    address: Address(
      name: "Alessandro",
      lastName: "Verdi",
      country: "Italia",
      address: "Viale Roma 88",
      cap: 20121,
    ),
    card: CreditCard(
      holder: "Alessandro Verdi",
      number: 9876987698769876,
      expiration: "2/30",
      cvv: 321,
    ),
    rating: 2,
    favouriteComics: [],
    followedUsers: [],
    comicsSale: [],
    reviews: [],
    sellings: [],
    purchases: [],
    connectedAccount: true,
  );
  comic1 = Comic(
    id: 1,
    seller: user1,
    title: "Spider-Man 2",
    description: "Spider-Man 2 variant",
    price: 5,
    conditions: Conditions.daEdicola,
    otherImagesPath: ['assets/comic_cover/spiderman2-cover.jpg', 'assets/comic_cover/spiderman2-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman2-cover.jpg',
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
    bookbinding: Binding.spillato,
  );
  comic2 = Comic(
    id: 2,
    seller: user1,
    title: "Spider-Man 3",
    description: "Spider-Man 3 variant",
    price: 5,
    conditions: Conditions.daEdicola,
    otherImagesPath: ['assets/comic_cover/spiderman3-cover.jpg', 'assets/comic_cover/spiderman3-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman3-cover.jpg',
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
    seller: user1,
    title: "Batman 4",
    description: "Batman 4",
    price: 5,
    conditions: Conditions.buone,
    otherImagesPath: ['assets/comic_cover/batman4-cover.jpg', 'assets/comic_cover/batman4-cover.jpg'],
    coverPath: 'assets/comic_cover/batman4-cover.jpg',
    authors: ["Chip Zdarsky", "Carmine Di Giandomenico"],
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
    isbn: null,
  );
  comic4 = Comic(
      id: 4,
      seller: user2,
      title: "Batman 5",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      price: 3,
      conditions: Conditions.daEdicola,
      otherImagesPath: ['assets/comic_cover/batman5-cover.jpg', 'assets/comic_cover/batman5-cover.jpg'],
      coverPath: 'assets/comic_cover/batman5-cover.jpg',
      authors: ["Brian Michael Bendis", "Mark Bagley"],
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
  comic5 = Comic(
    id: 5,
    seller: user2,
    title: "One Piece 25",
    description: "Le avventure di Rufy e della sua ciurma continuano nella saga di Alabasta.",
    price: 5,
    conditions: Conditions.buone,
    otherImagesPath: ['assets/comic_cover/onepiece25-cover.jpg'],
    coverPath: 'assets/comic_cover/onepiece25-cover.jpg',
    authors: ["Eiichiro Oda"],
    genre: [Genre.avventura],
    publicationYear: 2002,
    language: "Giapponese",
    originalPublisher: "Shueisha",
    series: "Weekly Shonen Jump",
    country: "Giappone",
    editionYear: 2002,
    isbn: 9784088732320,
  );
  comic6 = Comic(
    id: 6,
    seller: user2,
    title: "Tex 100",
    description: "Avventure western del leggendario ranger Tex Willer.",
    price: 4,
    conditions: Conditions.daEdicola,
    otherImagesPath: ['assets/comic_cover/tex100-cover.jpg'],
    coverPath: 'assets/comic_cover/tex100-cover.jpg',
    authors: ["Gianluigi Bonelli", "Aurelio Galleppini"],
    genre: [Genre.azione, Genre.avventura],
    publicationYear: 1968,
    language: "Italiano",
    italianPublisher: "Sergio Bonelli Editore",
    country: "Italia",
  );
  comic7 = Comic(
    id: 7,
    seller: user3,
    title: "Spider-Man: Blue",
    description: "Una storia emozionante di Peter Parker che ricorda i suoi primi amori.",
    price: 8,
    conditions: Conditions.ottime,
    otherImagesPath: ['assets/comic_cover/spidermanblue-cover.jpg'],
    coverPath: 'assets/comic_cover/spidermanblue-cover.jpg',
    authors: ["Jeph Loeb", "Tim Sale"],
    genre: [Genre.supereroi, Genre.romantico],
    publicationYear: 2002,
    language: "Inglese",
    originalPublisher: "Marvel Comics",
    variant: true,
    country: "USA",
  );
  comic8 = Comic(
    id: 8,
    seller: user3,
    title: "Asterix e Obelix e i Britanni",
    description: "Gli irriducibili Galli partono per aiutare i loro cugini in Britannia.",
    price: 6,
    conditions: Conditions.buone,
    otherImagesPath: ['assets/comic_cover/asterix-cover.jpg'],
    coverPath: 'assets/comic_cover/asterix-cover.jpg',
    authors: ["René Goscinny", "Albert Uderzo"],
    genre: [Genre.umoristico, Genre.avventura],
    publicationYear: 1966,
    language: "Italiano",
    originalPublisher: "Dargaud",
    series: "Asterix",
    country: "Francia",
  );
  comic9 = Comic(
    id: 9,
    seller: user3,
    title: "Naruto 15",
    description: "Sasuke decide il suo destino, mentre Naruto affronta nuove prove.",
    price: 5,
    conditions: Conditions.ottime,
    otherImagesPath: ['assets/comic_cover/naruto15-cover.jpg'],
    coverPath: 'assets/comic_cover/naruto15-cover.jpg',
    authors: ["Masashi Kishimoto"],
    genre: [Genre.avventura],
    publicationYear: 2001,
    language: "Italiano",
    originalPublisher: "Shueisha",
    series: "Weekly Shonen Jump",
    signed: true,
    country: "Giappone",
  );
  comic10 = Comic(
    id: 10,
    seller: user4,
    title: "Dylan Dog 50",
    description: "Un'indagine nel mondo dell'occulto con il celebre investigatore dell'incubo.",
    price: 3,
    conditions: Conditions.moltoUsato,
    otherImagesPath: ['assets/comic_cover/dylandog50-cover.jpg'],
    coverPath: 'assets/comic_cover/dylandog50-cover.jpg',
    authors: ["Tiziano Sclavi"],
    genre: [Genre.horror, Genre.thriller],
    publicationYear: 1990,
    language: "Italiano",
    italianPublisher: "Sergio Bonelli Editore",
    country: "Italia",
    editionYear: 1990,
  );
  comic11 = Comic(
    id: 11,
    seller: user4,
    title: "X-Men #1",
    description: "Il debutto del team di mutanti creato da Stan Lee e Jack Kirby.",
    price: 12,
    conditions: Conditions.buone,
    otherImagesPath: ['assets/comic_cover/xmen1-cover.jpg'],
    coverPath: 'assets/comic_cover/xmen1-cover.jpg',
    authors: ["Stan Lee", "Jack Kirby"],
    genre: [Genre.supereroi],
    publicationYear: 1963,
    language: "Inglese",
    originalPublisher: "Marvel Comics",
    graded: true,
    country: "USA",
  );
  comic12 = Comic(
    id: 12,
    seller: user4,
    title: "Blueberry: La giovinezza di Blueberry",
    description: "Le prime avventure del celebre cowboy francese.",
    price: 7,
    conditions: Conditions.daEdicola,
    otherImagesPath: ['assets/comic_cover/blueberry-cover.jpg'],
    coverPath: 'assets/comic_cover/blueberry-cover.jpg',
    authors: ["Jean-Michel Charlier", "Jean Giraud (Moebius)"],
    genre: [Genre.avventura],
    publicationYear: 1968,
    language: "Italiano",
    originalPublisher: "Dargaud",
    country: "Francia",
  );
  comic13 = Comic(
    id: 13,
    seller: user5,
    title: "Dragon Ball 10",
    description: "La saga del Gran Torneo Tenkaichi con Goku e i suoi amici.",
    price: 5,
    conditions: Conditions.ottime,
    otherImagesPath: ['assets/comic_cover/dragonball10-cover.jpg'],
    coverPath: 'assets/comic_cover/dragonball10-cover.jpg',
    authors: ["Akira Toriyama"],
    genre: [Genre.azione],
    publicationYear: 1987,
    language: "Giapponese",
    originalPublisher: "Shueisha",
    country: "Giappone",
  );
  comic14 = Comic(
    id: 14,
    seller: user5,
    title: "Zagor 200",
    description: "L'eroe di Darkwood affronta una nuova avventura mozzafiato.",
    price: 4,
    conditions: Conditions.buone,
    otherImagesPath: ['assets/comic_cover/zagor200-cover.jpg'],
    coverPath: 'assets/comic_cover/zagor200-cover.jpg',
    authors: ["Guido Nolitta", "Gallieno Ferri"],
    genre: [Genre.avventura],
    publicationYear: 1975,
    language: "Italiano",
    italianPublisher: "Sergio Bonelli Editore",
    series: "Zagor",
    country: "Italia",
    bookbinding: Binding.brossurato
  );
  comic15 = Comic(
    id: 15,
    seller: user5,
    title: "Watchmen",
    description: "La graphic novel che ha rivoluzionato il fumetto americano.",
    price: 15,
    conditions: Conditions.ottime,
    otherImagesPath: ['assets/comic_cover/watchmen-cover.jpg'],
    coverPath: 'assets/comic_cover/watchmen-cover.jpg',
    authors: ["Alan Moore", "Dave Gibbons"],
    genre: [Genre.supereroi, Genre.sciFi],
    publicationYear: 1986,
    language: "Inglese",
    originalPublisher: "DC Comics",
    country: "USA",
    signed: true,
    isbn: 9780930289232,
    bookbinding: Binding.cartonato
  );

    user1.comicsSale = [comic1, comic2, comic3];
    user2.comicsSale = [comic4, comic5, comic6];
    user3.comicsSale = [comic7, comic8, comic9];
    user4.comicsSale = [comic10, comic11, comic12];
    user5.comicsSale = [comic13, comic14, comic15];
    user1.reviews = [Review(stars: 3, description: "Descrizione della recensione", user: user2)];
    user2.reviews = [Review(stars: 5, description: "Descrizione della recensione", user: user1)];
    user3.reviews = [Review(stars: 4, description: "Descrizione della recensione", user: user4)];
    user4.reviews = [Review(stars: 5, description: "Descrizione della recensione", user: user5)];
    user5.reviews = [Review(stars: 2, description: "Descrizione della recensione", user: user3)];
  }

  static List<Comic> allComics = [
    SampleData.comic1,
    SampleData.comic2,
    SampleData.comic3,
    SampleData.comic4,
    SampleData.comic5,
    SampleData.comic6,
    SampleData.comic7,
    SampleData.comic8,
    SampleData.comic9,
    SampleData.comic10,
    SampleData.comic11,
    SampleData.comic12,
    SampleData.comic13,
    SampleData.comic14,
    SampleData.comic15,
  ];
  static List<User> allUsers = [user1, user2, user3, user4, user5];

  static List<String> allAuthors = [
    "Chip Zdarsky",
    "Carmine Di Giandomenico",
    "Werther Dell'Edera",
    "Simone di Meo",
    "Sio",
    "Zerocalcare",
    "Brian Michael Bendis",
    "Mark Bagley",
    "Alan Moore",
    "Frank Miller",
    "Osamu Tezuka",
    "Hergé",
    "Jacques Tardi",
    "Grant Morrison",
    "Matsumoto Leiji",
    "Garth Ennis",
    "Jim Lee",
    "Neil Gaiman",
    "Moebius",
    "Marjane Satrapi",
    "Katsuhiro Otomo",
    "Mark Millar",
    "Stan Lee",
    "Milo Manara",
    "Raina Telgemeier",
    "Brian K. Vaughan",
    "Yoh Yoshinari",
    "Carlos Giménez",
  ];

  // Simulated chat 1
  static Message c1_msg1 = Message(
    sender: user2,
    receiver: user1,
    text: "Ciao. A quanto lo vendi il numero 3 di Spider-Man?",
    date: DateTime(2025, 7, 2)
  );
  static Message c1_msg2 = Message(
    sender: user1,
      receiver: user2,
    text: "Salve. Il prezzo pubblicato è 3€ ma posso fare uno sconto",
    date: DateTime(2025, 7, 3)
  );
  static Chat chat1 = Chat([c1_msg1, c1_msg2], user2, user1, comic2, true);

  // Simulated chat 2
  static Message c2_msg1 = Message(
    sender: user2,
      receiver: user1,
    text:  "Ciao. Voglio tutto a 1€",
    date: DateTime(2025, 6, 29)
  );
  static Message c2_msg2 = Message(
    sender: user1,
      receiver: user2,
    text: "Ok va bene",
    date: DateTime(2025, 6, 30)
  );
  static Chat chat2 = Chat([c2_msg1, c2_msg2], user2, user1, comic2, false);

  static List<Chat> allChats = [chat1, chat2];
}