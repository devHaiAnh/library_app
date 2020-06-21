import 'dart:convert';

class LoginModel {
    Member member;
    String message;
    int state;

    LoginModel({
        this.member,
        this.message,
        this.state,
    });

    factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
        message: json["message"] == null ? null : json["message"],
        state: json["state"] == null ? null : json["state"],
    );

    Map<String, dynamic> toJson() => {
        "member": member == null ? null : member.toJson(),
        "message": message == null ? null : message,
        "state": state == null ? null : state,
    };
}

class Member {
    bool admin;
    String email;
    String name;
    String password;
    String address;
    String username;

    Member({
        this.admin,
        this.email,
        this.name,
        this.password,
        this.address,
        this.username,
    });

    factory Member.fromRawJson(String str) => Member.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        admin: json["admin"] == null ? null : json["admin"],
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        password: json["password"] == null ? null : json["password"],
        address: json["address"] == null ? null : json["address"],
        username: json["username"] == null ? null : json["username"],
    );

    Map<String, dynamic> toJson() => {
        "admin": admin == null ? null : admin,
        "email": email == null ? null : email,
        "name": name == null ? null : name,
        "password": password == null ? null : password,
        "address": address == null ? null : address,
        "username": username == null ? null : username,
    };
}
