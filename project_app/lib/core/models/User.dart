import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

List<User> usersFromJson(List lst) =>
    lst.map((e) => userFromJson(jsonEncode(e))).toList();

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.userName,
    this.passWord,
    this.firstName,
    this.lastName,
    this.tel,
    this.email,
  });

  int id;
  String userName;
  String passWord;
  String firstName;
  String lastName;
  String tel;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["userName"],
    passWord: json["passWord"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    tel: json["tel"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "passWord": passWord,
    "firstName": firstName,
    "lastName": lastName,
    "tel": tel,
    "email": email,
  };


  @override
  String toString() {
    return 'User{id: $id, userName: $userName, passWord: $passWord, firstName: $firstName, lastName: $lastName, tel: $tel, email: $email}';
  }
}