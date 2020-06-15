// To parse this JSON data, do
//
//     final cartsModel = cartsModelFromJson(jsonString);

import 'dart:convert';

class CartsModel {
    CartsModel({
        this.carts,
        this.message,
    });

    List<Cart> carts;
    String message;

    factory CartsModel.fromRawJson(String str) => CartsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartsModel.fromJson(Map<String, dynamic> json) => CartsModel(
        carts: json["carts"] == null ? null : List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "carts": carts == null ? null : List<dynamic>.from(carts.map((x) => x.toJson())),
        "message": message == null ? null : message,
    };
}

class Cart {
    Cart({
        this.author,
        this.cost,
        this.count,
        this.description,
        this.evaluateBook,
        this.image,
        this.name,
        this.username,
    });

    String author;
    double cost;
    int count;
    String description;
    double evaluateBook;
    String image;
    String name;
    String username;

    factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        author: json["author"] == null ? null : json["author"],
        cost: json["cost"] == null ? null : json["cost"].toDouble(),
        count: json["count"] == null ? null : json["count"],
        description: json["description"] == null ? null : json["description"],
        evaluateBook: json["evaluateBook"] == null ? null : json["evaluateBook"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
    );

    Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "cost": cost == null ? null : cost,
        "count": count == null ? null : count,
        "description": description == null ? null : description,
        "evaluateBook": evaluateBook == null ? null : evaluateBook,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
    };
}
