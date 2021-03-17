import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

List<User> usersFromJson(List lst) =>
    lst.map((e) => userFromJson(jsonEncode(e))).toList();

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.username,
    this.password,
  });

  int id;
  String username;
  String password;

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password}';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
      };
}
