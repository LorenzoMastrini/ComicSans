import 'package:comicsans/comic.dart';
import 'package:comicsans/review.dart';
import 'package:comicsans/user.dart';
import 'package:comicsans/CreditCard.dart';
import 'package:comicsans/address.dart';
import 'Components/ReviewComponent.dart';

class SampleData{
  static late User user1, user2;
  static late Comic comic1, comic2, comic3, comic4;

static void init(){
  user1 = User(
      id: 1,
      username: "Lemo5£",
      name: "Lemorzo",
      lastName: "Da Palermo",
      email: "prova1@prova.com",
      password: "1234",
      imagePath: "",
      gend: Gender.Maschio,
      birthday: "5/7/2001",
      addr: Address(
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
      purchases: []
  );
  user2 = User(
      id: 2,
      username: "Sex Machine",
      name: "Giovanni",
      lastName: "Carlini",
      email: "prova2@prova.com",
      password: "1234",
      imagePath: "",
      gend: Gender.Maschio,
      birthday: "5/7/2001",
      reviews: [],
      addr: Address(
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
      purchases: []
  );
  comic1 = Comic(
    id: 1,
    seller: user1,
    title: "Spider-Man 2",
    description: "Spider-Man 2 variant",
    price: 5,
    cond: Conditions.DaEdicola,
    imagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman-cover.jpg',
    authors: ["Brian Michael Bendis","Mark Bagley"],
    gen: [Genre.Supereroi],
    publishYear: 2004,
    language: "Italiano",
    italianEditor: "Panini Comics",
    originalPublisher: "Marvel Comics",
    series: "",
    originCountry: "USA",
    variant: true,
    graded: false,
    signed: false,
    editionYear: 2004,
    isbn: 1234567890,
  );
  comic2 = Comic(
    id: 2,
    seller: user1,
    title: "Spider-Man 3",
    description: "Spider-Man 3 variant",
    price: 5,
    cond: Conditions.DaEdicola,
    imagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman-cover.jpg',
    authors: ["Brian Michael Bendis","Mark Bagley"],
    gen: [Genre.Supereroi],
    publishYear: 2004,
    language: "Italiano",
    italianEditor: "Panini Comics",
    originalPublisher: "Marvel Comics",
    series: "",
    originCountry: "USA",
    variant: true,
    graded: false,
    signed: false,
    editionYear: 2004,
    isbn: 1234567890,
  );
  comic3 = Comic(
    id: 3,
    seller: user2,
    title: "Batman 4",
    description: "Batman 4",
    price: 5,
    cond: Conditions.Buone,
    imagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
    coverPath: 'assets/comic_cover/spiderman-cover.jpg',
    authors: ["Chip Zdarsky, Carmine Di Giandomenico"],
    gen: [Genre.Supereroi],
    publishYear: 2010,
    language: "Italiano",
    italianEditor: "Panini Comics",
    originalPublisher: "",
    series: "",
    originCountry: "USA",
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
      price: 5,
      cond: Conditions.Buone,
      imagesPath: ['assets/comic_cover/spiderman-cover.jpg', 'assets/comic_cover/spiderman-cover.jpg'],
      coverPath: 'assets/comic_cover/spiderman-cover.jpg',
      authors: ["Chip Zdarsky, Carmine Di Giandomenico"],
      gen: [Genre.Supereroi],
      publishYear: 2010,
      language: "Italiano",
      italianEditor: "Panini Comics",
      originalPublisher: "",
      series: "",
      originCountry: "USA",
      variant: false,
      graded: false,
      signed: false,
      editionYear: 2010,
      isbn: 0
  );
  user1.comicsSale = [comic1, comic2];
  user2.comicsSale = [comic3, comic4];
  user1.reviews = [Review(stars: 5, description: "Descrizione della recensione", user: user2)];
  user2.reviews = [Review(stars: 5, description: "Descrizione della recensione", user: user1)];
}
static List<Comic> allComics = [
  comic1,
  comic2,
  comic3,
  comic4
];
static List<User> allUsers = [
  user1,
  user2,
];
}