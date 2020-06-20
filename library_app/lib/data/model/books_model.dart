import 'dart:convert';

class BooksModel {
  List<Book> books;
  String message;

  BooksModel({
    this.books,
    this.message,
  });

  factory BooksModel.fromRawJson(String str) =>
      BooksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
        books: json["books"] == null
            ? null
            : List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "books": books == null
            ? null
            : List<dynamic>.from(books.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class Book {
  String achievements;
  String author;
  String category;
  double cost;
  String cover;
  String description;
  double evaluateAuthor;
  double evaluateBook;
  String image;
  String imageAuthor;
  String language;
  String name;
  int pages;
  String writingGenre;
  bool bookmark;

  Book({
    this.achievements,
    this.author,
    this.category,
    this.cost,
    this.cover,
    this.description,
    this.evaluateAuthor,
    this.evaluateBook,
    this.image,
    this.imageAuthor,
    this.language,
    this.name,
    this.pages,
    this.writingGenre,
    this.bookmark
  });

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        achievements:
            json["achievements"] == null ? null : json["achievements"],
        author: json["author"] == null ? null : json["author"],
        category: json["category"] == null ? null : json["category"],
        cost: json["cost"] == null ? null : json["cost"].toDouble(),
        cover: json["cover"] == null ? null : json["cover"],
        description: json["description"] == null ? null : json["description"],
        evaluateAuthor:
            json["evaluateAuthor"] == null ? null : json["evaluateAuthor"],
        evaluateBook:
            json["evaluateBook"] == null ? null : json["evaluateBook"],
        image: json["image"] == null ? null : json["image"],
        imageAuthor: json["imageAuthor"] == null ? null : json["imageAuthor"],
        language: json["language"] == null ? null : json["language"],
        name: json["name"] == null ? null : json["name"],
        pages: json["pages"] == null ? null : json["pages"],
        writingGenre:
            json["writingGenre"] == null ? null : json["writingGenre"],
      );

  Map<String, dynamic> toJson() => {
        "achievements": achievements == null ? null : achievements,
        "author": author == null ? null : author,
        "category": category == null ? null : category,
        "cost": cost == null ? null : cost,
        "cover": cover == null ? null : cover,
        "description": description == null ? null : description,
        "evaluateAuthor": evaluateAuthor == null ? null : evaluateAuthor,
        "evaluateBook": evaluateBook == null ? null : evaluateBook,
        "image": image == null ? null : image,
        "imageAuthor": imageAuthor == null ? null : imageAuthor,
        "language": language == null ? null : language,
        "name": name == null ? null : name,
        "pages": pages == null ? null : pages,
        "writingGenre": writingGenre == null ? null : writingGenre,
      };
}
