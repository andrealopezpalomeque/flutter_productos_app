import 'dart:convert';

class Product {
  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
    this.id,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  String toJson() => json.encode(toMap());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      // Assuming your Product class has properties like name, price, etc.
      name: map['name'],
      price: map['price'],
      available: map['available'],
      picture: map['picture'],
    );
  }

// copy() method to create a copy of the object
  Product copy() => Product(
        available: available,
        name: name,
        picture: picture,
        price: price,
        id: id,
      );
}
