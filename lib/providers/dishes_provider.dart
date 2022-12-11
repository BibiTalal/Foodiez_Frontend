import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:foodiez_frontent/widgets.dart';
import 'package:foodiez_frontent/models/ingredients.dart';

class DishProvider extends ChangeNotifier {
  List<Dish> dishes = [];

  bool isLoading = false;

  DishProvider() {
    loadDishes();
  }

  Future<void> loadDishes() async {
    isLoading = true;
    dishes.clear();
    // notifyListeners();

    var response = await Client.dio.get("http://10.0.2.2:8000/dish/");

    var dishesJsonL = response.data as List;

    dishes = dishesJsonL.map((dishJson) => Dish.fromMap(dishJson)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addDish({
    required String? name,
    required File? image,
    required int? cuisine,
    required List<Ingredients>? selectedIngredients,
  }) async {
    // isLoading = true;
    // notifyListeners();

    // Dio client = Dio();

    var response = await Client.dio.post("http://10.0.2.2:8000/dishes/create/",
        data: FormData.fromMap({
          "name": name,
          "image": await MultipartFile.fromFile(image!.path),
          "cuisine": cuisine,
          "ingredients": selectedIngredients!.map((e) => e.id).toList(),
        }));

    await loadDishes();
  }

  addCuisine({required String name, required File image}) {}
  Future<void> editDish({
    required int id,
    required String? name,
    required File image,
    required int cuisine,
    required List<Ingredients> selectedIngredients,
  }) async {
    var response =
        await Client.dio.patch("http://10.0.2.2:8000/dishes/update/$id/",
            data: FormData.fromMap({
              // if (name != null && name.isNotEmpty) "name": name,
              // if (image != null)
              //   "image": await MultipartFile.fromFile(image.path),
              "name": name,
              "ingredient": selectedIngredients.map((e) => e.id).toList(),
              "cuisine": cuisine,
              "image": await MultipartFile.fromFile(image.path),
            }));

    loadDishes();
  }

  Future<void> deleteDish({
    required int id,
  }) async {
    var response =
        await Client.dio.delete("http://10.0.2.2:8000/dish/delete/${id}/");
    loadDishes();
  }
}
  

//   Future<void> editCuisine({
//     required Cuisine cuisine,
//     required String? name,
//     required File? image,
//   }) async {
//     isLoading = true;
//     notifyListeners();

//     Dio client = Dio();

//     await client.put("http://127.0.0.1:8000/${cuisine.id}",
//         data: FormData.fromMap({
//           "name": name ?? cuisine.name,
//           if (image != null) "image": await MultipartFile.fromFile(image.path),
//         }));

//     await loadCuisines();
//   }
// }

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

