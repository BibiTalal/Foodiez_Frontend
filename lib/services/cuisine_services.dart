import 'dart:io';
import 'package:go_router/go_router.dart';
import "package:dio/dio.dart";
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';

Future<List<Cuisine>> getcuisines() async {
  Dio client = Dio();
  List<Cuisine> cuisines = [];
  try {
    Response response = await client.get("http://127.0.0.1:8000/");
    cuisines = (response.data as List)
        .map((cuisine) => Cuisine.fromJson(cuisine))
        .toList();
  } on DioError catch (error) {
    print("Check Connection $error");
  }
  return cuisines;
}
