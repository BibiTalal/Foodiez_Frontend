// import 'package:json_annotation/json_annotation.dart';

// part 'cuisine.g.dart';
import 'dart:convert';

// @JsonSerializable()
class Dish {
  int id;
  String name;
  String image;
  int cuisine;
  List<int> ingredients;
  // int age;
  // bool adopted;
  // String gender;

  Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.ingredients,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'cuisine': cuisine,
      'ingredients': ingredients,
    };
  }

  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      cuisine: map['category']?.toInt() ?? 0,
      ingredients: List<int>.from(map['ingredients']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dish.fromJson(String source) => Dish.fromMap(json.decode(source));
}
