import 'package:foodiez_frontent/services/dishes_services.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:foodiez_frontent/widgets.dart';

class DishProvider extends ChangeNotifier {
  List<Dish> dishes = [
    Dish(
      name: "Pasta",
      image:
          "https://www.budgetbytes.com/wp-content/uploads/2013/07/Creamy-Spinach-Tomato-Pasta-bowl-500x500.jpg",
    ),
    Dish(
      name: "Pizza",
      image: "https://static.toiimg.com/photo/msid-87930581/87930581.jpg",
    )
  ];

  bool isLoading = false;

  DishProvider() {
    loadDishes();
  }

  Future<void> loadDishes() async {
    isLoading = true;
    notifyListeners();

    Dio client = Dio();

    var response = await client.get("http://10.0.2.2:8000/");

    var dishesJson = response.data as List;

    dishes = dishesJson
        .map((dishJson) => Dish(
              id: dishJson['id'],
              name: dishJson['title'],
              image: dishJson['image'],
            ))
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addDish({
    required String name,
    required File image,
    required int? cuisine,
  }) async {
    isLoading = true;
    notifyListeners();

    Dio client = Dio();

    await client.post("http://10.0.2.2:8000/",
        data: FormData.fromMap({
          "name": name,
          "image": await MultipartFile.fromFile(image.path),
          "cuisine": cuisine,
        }));

    await loadDishes();
  }

  addCuisine({required String name, required File image}) {}
  Future<void> editDish({
    required int id,
    required String name,
    required int cuisine,
    required File image,
  }) async {
    var response = await Client.dio.put("http://10.0.2.2:8000/${id}/",
        data: FormData.fromMap({
          "name": name,
          "cuisine": cuisine,
          "image": await MultipartFile.fromFile(image.path),
        }));

    loadDishes();
  }
}

// class CuisinesProvider extends ChangeNotifier {
//   List<Cuisine> cuisines = [
//     Cuisine(
//       name: "Italian",
//       image:
//           "https://www.lacademie.com/wp-content/uploads/2022/01/the-delicious-foods-of-italian-cuisine.jpg",
//     ),
//     Cuisine(
//       name: "Indian",
//       image:
//           "https://www.tasteofhome.com/wp-content/uploads/2021/01/tasty-butter-chicken-curry-dish-from-indian-cuisine-1277362334.jpg?fit=700,700",
//     )
//   ];

//   Future<List> get() async {
//     notifyListeners();
//     cuisines = await getcuisines();
//     return cuisines;
//   }

//   void addCuisine({
//     required String name,
//     required String image,
//     // Cuisine model = Cuisine(name: cuisine, image: cuisine);
//     // cuisines.add(model);
//     // notifyListeners();
//   })

//   void deleteCuisine(int index) {
//     cuisines.removeAt(index);
//     notifyListeners();
//   }
// }
