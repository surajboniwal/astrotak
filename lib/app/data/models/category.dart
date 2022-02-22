import 'dart:convert';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.suggestions,
  });

  final int id;
  final String name;
  final String? description;
  final double price;
  final List<String> suggestions;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        price: double.parse(json["price"].toString()),
        suggestions: List<String>.from(json["suggestions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "suggestions": List<dynamic>.from(suggestions.map((x) => x)),
      };
}
