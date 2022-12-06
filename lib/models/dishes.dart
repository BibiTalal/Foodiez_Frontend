import 'package:json_annotation/json_annotation.dart';

part 'dishes.g.dart';

@JsonSerializable()
class Dish {
  int? id;
  String name;
  String image;
  // int age;
  // bool adopted;
  // String gender;

  Dish({
    this.id,
    required this.name,
    required this.image,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);

  // Pet.fromJson(Map<String, dynamic> json)
  //     : id = json['id'] as int?,
  //       name = json['name'] as String,
  //       adopted = json['adopted'] as bool,
  //       image = json['image'] as String,
  //       age = json['age'] as int,
  //       gender = json['gender'] as String;

}
