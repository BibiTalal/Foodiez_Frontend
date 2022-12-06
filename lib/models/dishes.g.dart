part of 'dishes.dart';

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      id: json['id'] as int?,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
