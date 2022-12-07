import 'package:foodiez_frontent/services/cuisine_services.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class CuisineProvider extends ChangeNotifier {
  List<Cuisine> cuisines = [
    Cuisine(
      name: "Italian",
      image:
          "https://www.lacademie.com/wp-content/uploads/2022/01/the-delicious-foods-of-italian-cuisine.jpg",
    ),
    Cuisine(
      name: "Indian",
      image:
          "https://www.tasteofhome.com/wp-content/uploads/2021/01/tasty-butter-chicken-curry-dish-from-indian-cuisine-1277362334.jpg?fit=700,700",
    )
  ];

  bool isLoading = false;

  CuisineProvider() {
    loadCuisines();
  }

  Future<void> loadCuisines() async {
    isLoading = true;
    notifyListeners();

    Dio client = Dio();

    var response = await client.get("");

    var cuisinesJson = response.data as List;

    cuisines = cuisinesJson
        .map((cuisineJson) => Cuisine(
              id: cuisineJson['id'],
              name: cuisineJson['title'],
              image: cuisineJson['image'],
            ))
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addCuisine({
    required String name,
    required File image,
  }) async {
    isLoading = true;
    notifyListeners();

    Dio client = Dio();

    await client.post("",
        data: FormData.fromMap({
          "name": name,
          "image": await MultipartFile.fromFile(image.path),
        }));

    await loadCuisines();
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
