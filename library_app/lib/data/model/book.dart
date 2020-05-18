class Book {
  String image;
  String name;
  String author;
  double star;
  String description;
  String category;
  int pages;
  String cover;
  String language;
  int cost;
  Book({
    this.image,
    this.name,
    this.author,
    this.star,
    this.description,
    this.category,
    this.pages,
    this.cover,
    this.language,
    this.cost,
  });
}

List<Book> bookList = [
  Book(
    image:
        "https://images-na.ssl-images-amazon.com/images/I/51RlUeEoCAL._SL300_.jpg",
    name: "Cidade dos Ossos",
    author: "Lorna Balian",

  ),
];
