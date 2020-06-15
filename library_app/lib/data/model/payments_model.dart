import 'dart:convert';

class PaymentsModel {
    PaymentsModel({
        this.message,
        this.payments,
    });

    String message;
    List<Payment> payments;

    factory PaymentsModel.fromRawJson(String str) => PaymentsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        message: json["message"] == null ? null : json["message"],
        payments: json["payments"] == null ? null : List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "payments": payments == null ? null : List<dynamic>.from(payments.map((x) => x.toJson())),
    };
}

class Payment {
    Payment({
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

    factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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
