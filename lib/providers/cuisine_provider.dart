import 'package:foodiez_frontent/services/cuisine_services.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/cuisine.dart';

class CuisinesProvider extends ChangeNotifier {
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

  Future<List> get() async {
    notifyListeners();
    cuisines = await getcuisines();
    return cuisines;
  }

  void addCuisine(String cuisine) {
    Cuisine model = Cuisine(name: cuisine, image: cuisine);
    cuisines.add(model);
    notifyListeners();
  }

  void deleteCuisine(int index) {
    cuisines.removeAt(index);
    notifyListeners();
  }
}
