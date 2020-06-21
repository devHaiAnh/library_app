import 'dart:convert';

class MembersModel {
    List<Member> members;
    String message;

    MembersModel({
        this.members,
        this.message,
    });

    factory MembersModel.fromRawJson(String str) => MembersModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MembersModel.fromJson(Map<String, dynamic> json) => MembersModel(
        members: json["members"] == null ? null : List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "members": members == null ? null : List<dynamic>.from(members.map((x) => x.toJson())),
        "message": message == null ? null : message,
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
