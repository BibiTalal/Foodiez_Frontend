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
    // this.adopted = false,
    // required this.age,
    // required this.gender
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) =>
      _$CuisineFromJson(json);
  Map<String, dynamic> toJson() => _$CuisineToJson(this);

  // Pet.fromJson(Map<String, dynamic> json)
  //     : id = json['id'] as int?,
  //       name = json['name'] as String,
  //       adopted = json['adopted'] as bool,
  //       image = json['image'] as String,
  //       age = json['age'] as int,
  //       gender = json['gender'] as String;

}
