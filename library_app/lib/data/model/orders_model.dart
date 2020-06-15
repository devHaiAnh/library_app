import 'dart:convert';

class OrdersModel {
    OrdersModel({
        this.message,
        this.orders,
    });

    String message;
    List<Order> orders;

    factory OrdersModel.fromRawJson(String str) => OrdersModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        message: json["message"] == null ? null : json["message"],
        orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.author,
        this.cost,
        this.count,
        this.evaluateBook,
        this.expirationDate,
        this.image,
        this.name,
        this.registrationDate,
        this.status,
        this.username,
    });

    String author;
    double cost;
    int count;
    double evaluateBook;
    int expirationDate;
    String image;
    String name;
    int registrationDate;
    int status;
    String username;

    factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        author: json["author"] == null ? null : json["author"],
        cost: json["cost"] == null ? null : json["cost"].toDouble(),
        count: json["count"] == null ? null : json["count"],
        evaluateBook: json["evaluateBook"] == null ? null : json["evaluateBook"].toDouble(),
        expirationDate: json["expirationDate"] == null ? null : json["expirationDate"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        registrationDate: json["registrationDate"] == null ? null : json["registrationDate"],
        status: json["status"] == null ? null : json["status"],
        username: json["username"] == null ? null : json["username"],
    );

    Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "cost": cost == null ? null : cost,
        "count": count == null ? null : count,
        "evaluateBook": evaluateBook == null ? null : evaluateBook,
        "expirationDate": expirationDate == null ? null : expirationDate,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "registrationDate": registrationDate == null ? null : registrationDate,
        "status": status == null ? null : status,
        "username": username == null ? null : username,
    };
}
