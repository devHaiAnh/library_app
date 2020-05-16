class Member {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String password;
  final bool type;
  Member({this.username,this.name, this.email, this.phone, this.password, this.type});
}

List<Member> memberList = [
  Member(
    username: "this",
    name: "Hai",
    email: "anhbps@fpt.edu.vn",
    phone: "012345678",
    password: "12345678",
    type: false,
  ),
  Member(
    username: "is",
    name: "Hai",
    email: "anhbps@fpt.edu.vn",
    phone: "012345678",
    password: "12345678",
    type: true,
  ),
  Member(
    username: "a",
    name: "Hai",
    email: "anhbps@fpt.edu.vn",
    phone: "012345678",
    password: "12345678",
    type: true,
  ),
  Member(
    username: "handsome boy",
    name: "Hai",
    email: "anhbps@fpt.edu.vn",
    phone: "012345678",
    password: "12345678",
    type: false,
  ),
];
