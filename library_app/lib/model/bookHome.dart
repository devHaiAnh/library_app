class Book {
  String image;
  String name;
  String author;
  String imageAuthor;
  String writingGenre;
  String achievements;
  double evaluate;
  double star;
  String category;
  int pages;
  String cover;
  String language;
  String description;
  bool bookMark;
  Book(
      {this.image,
      this.name,
      this.author,
      this.imageAuthor,
      this.writingGenre,
      this.achievements,
      this.evaluate,
      this.star,
      this.category,
      this.pages,
      this.cover,
      this.language,
      this.description,
      this.bookMark});
}

List<Book> bookList = [
  Book(
    image:
        "https://images-na.ssl-images-amazon.com/images/I/414JfiBCutL._SX327_BO1,204,203,200_.jpg",
    name: "Becoming",
    author: "Michelle Obama",
    imageAuthor:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Michelle_Obama_2013_official_portrait.jpg/220px-Michelle_Obama_2013_official_portrait.jpg",
    writingGenre: "Business",
    achievements: "The author is beloved",
    evaluate: 5.0,
    star: 5.0,
    category: "Business",
    pages: 365,
    cover: "Hard",
    language: "English",
    description:
        "This is description1. This is description1. This is description1. This is description1. This is description1. This is description1.",
    bookMark: false,
  ),
  Book(
    image: "https://m.media-amazon.com/images/I/51rg3ZqDLsL.jpg",
    name: "Camino",
    author: "John Grisham",
    imageAuthor:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/John_Grisham_2009.jpg/220px-John_Grisham_2009.jpg",
    writingGenre: "Horror",
    achievements: "The author is beloved",
    evaluate: 5.0,
    star: 3.0,
    category: "Animal",
    pages: 366,
    cover: "Hard",
    language: "English",
    description:
        "This is description1. This is description1. This is description1. This is description1. This is description1. This is description1.",
    bookMark: false,
  ),
  Book(
    image: "https://m.media-amazon.com/images/I/51A29xxrpRL.jpg",
    name: "We're True",
    author: "Gabrielle Union",
    imageAuthor:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Gabrielle_union_podcast.png/220px-Gabrielle_union_podcast.png",
    writingGenre: "Romance",
    achievements: "The author is beloved",
    evaluate: 5.0,
    star: 5.0,
    category: "Comic",
    pages: 367,
    cover: "Hard",
    language: "English",
    description:
        "This is description1. This is description1. This is description1. This is description1. This is description1. This is description1.",
    bookMark: false,
  ),
];
