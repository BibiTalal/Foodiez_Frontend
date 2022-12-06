import 'dart:io';
import 'package:go_router/go_router.dart';
import "package:dio/dio.dart";
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/providers/dishes_provider.dart';

Future<List<Dish>> getdishes() async {
  Dio client = Dio();
  List<Dish> dishes = [];
  try {
    Response response = await client.get("http://127.0.0.1:8000/");
    dishes =
        (response.data as List).map((dish) => Dish.fromJson(dish)).toList();
  } on DioError catch (error) {
    print("Check Connection $error");
  }
  return dishes;
}
