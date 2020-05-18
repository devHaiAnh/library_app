class Member {
  String username;
  String password;
  String name;
  String email;
  String phone;
  bool admin;
  Member(
      {this.username,
      this.password,
      this.name,
      this.email,
      this.phone,
      this.admin});
}

List<Member> memberList = [
  Member(
    username: "member1",
    password: "12345678",
    name: "Member1",
    email: "member1@lib.com",
    phone: "012345678",
    admin: true,
  ),
  Member(
    username: "member2",
    password: "12345678",
    name: "Member2",
    email: "member2@lib.com",
    phone: "012345678",
    admin: false,
  ),
  Member(
    username: "member3",
    password: "12345678",
    name: "Member3",
    email: "member3@lib.com",
    phone: "012345678",
    admin: false,
  ),
  Member(
    username: "member4",
    password: "12345678",
    name: "Member4",
    email: "member4@lib.com",
    phone: "012345678",
    admin: false,
  ),
  Member(
    username: "member5",
    password: "12345678",
    name: "Member5",
    email: "member5@lib.com",
    phone: "012345678",
    admin: false,
  ),
];
