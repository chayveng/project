import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.userId,
    this.name,
  });

  int id;
  int userId;
  String name;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    userId: json['userId'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'name': name,
  };
}
