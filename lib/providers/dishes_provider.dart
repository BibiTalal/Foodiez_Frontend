import 'package:foodiez_frontent/services/dishes_services.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:flutter/material.dart';

class DishesProvider extends ChangeNotifier {
  List<Dish> dishes = [
    Dish(
      name: "Pasta",
      image:
          "https://www.budgetbytes.com/wp-content/uploads/2013/07/Creamy-Spinach-Tomato-Pasta-bowl-500x500.jpg",
    ),
    Dish(
      name: "Pizza",
      image:
          "https://static.toiimg.com/thumb/resizemode-4,width-1200,height-900,msid-87930581/87930581.jpg",
    )
  ];

  Future<List> getdish() async {
    notifyListeners();
    dishes = await getdishes();
    return dishes;
  }
}
