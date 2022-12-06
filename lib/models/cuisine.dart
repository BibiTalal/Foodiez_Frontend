import 'package:json_annotation/json_annotation.dart';

part 'cuisine.g.dart';

@JsonSerializable()
class Cuisine {
  int? id;
  String name;
  String image;
  // int age;
  // bool adopted;
  // String gender;

  Cuisine({
    this.id,
    required this.name,
    required this.image,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) =>
      _$CuisineFromJson(json);
  Map<String, dynamic> toJson() => _$CuisineToJson(this);
}
