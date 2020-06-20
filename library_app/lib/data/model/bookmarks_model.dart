// To parse this JSON data, do
//
//     final bookmarksModel = bookmarksModelFromJson(jsonString);

import 'dart:convert';

class BookmarksModel {
    BookmarksModel({
        this.bookmarks,
        this.message,
    });

    List<Bookmark> bookmarks;
    String message;

    factory BookmarksModel.fromRawJson(String str) => BookmarksModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BookmarksModel.fromJson(Map<String, dynamic> json) => BookmarksModel(
        bookmarks: json["bookmarks"] == null ? null : List<Bookmark>.from(json["bookmarks"].map((x) => Bookmark.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "bookmarks": bookmarks == null ? null : List<dynamic>.from(bookmarks.map((x) => x.toJson())),
        "message": message == null ? null : message,
    };
}

class Bookmark {
    Bookmark({
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
        this.username,
        this.writingGenre,
    });

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
    String username;
    String writingGenre;

    factory Bookmark.fromRawJson(String str) => Bookmark.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        achievements: json["achievements"] == null ? null : json["achievements"],
        author: json["author"] == null ? null : json["author"],
        category: json["category"] == null ? null : json["category"],
        cost: json["cost"] == null ? null : json["cost"].toDouble(),
        cover: json["cover"] == null ? null : json["cover"],
        description: json["description"] == null ? null : json["description"],
        evaluateAuthor: json["evaluateAuthor"] == null ? null : json["evaluateAuthor"],
        evaluateBook: json["evaluateBook"] == null ? null : json["evaluateBook"],
        image: json["image"] == null ? null : json["image"],
        imageAuthor: json["imageAuthor"] == null ? null : json["imageAuthor"],
        language: json["language"] == null ? null : json["language"],
        name: json["name"] == null ? null : json["name"],
        pages: json["pages"] == null ? null : json["pages"],
        username: json["username"] == null ? null : json["username"],
        writingGenre: json["writingGenre"] == null ? null : json["writingGenre"],
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
        "username": username == null ? null : username,
        "writingGenre": writingGenre == null ? null : writingGenre,
    };
}
