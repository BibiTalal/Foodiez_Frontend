// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuisine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cuisine _$CuisineFromJson(Map<String, dynamic> json) => Cuisine(
      id: json['id'] as int?,
      name: json['name'] as String,
      image: json['image'] as String,
      // adopted: json['adopted'] as bool? ?? false,
      // age: json['age'] as int,
      // gender: json['gender'] as String,
    );

Map<String, dynamic> _$CuisineToJson(Cuisine instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      // 'age': instance.age,
      // 'adopted': instance.adopted,
      // 'gender': instance.gender,
    };
