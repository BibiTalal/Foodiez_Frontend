// import 'package:json_annotation/json_annotation.dart';

// part 'cuisine.g.dart';
import 'dart:convert';

// @JsonSerializable()
class Cuisine {
  int id;
  String name;
  String image;
  // int age;
  // bool adopted;
  // String gender;

  Cuisine({
    required this.id,
    required this.name,
    required this.image,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Cuisine.fromMap(Map<String, dynamic> map) {
    return Cuisine(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cuisine.fromJson(String source) =>
      Cuisine.fromMap(json.decode(source));
}
