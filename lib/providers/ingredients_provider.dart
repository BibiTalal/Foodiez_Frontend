import 'package:dio/dio.dart';
import 'package:foodiez_frontent/models/ingredients.dart';
import 'package:foodiez_frontent/screens/addingredients.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:flutter/material.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredients> ingredients = [];
  bool isLoading = false;

  IngredientsProvider() {
    loadIngredients();
  }

  Future<void> loadIngredients() async {
    isLoading = true;
    ingredients.clear();

    var response =
        await Client.dio.get("http://10.0.2.2:8000/list/ingrediants/");
    var ingredientsJsonList = response.data as List;

    ingredients = ingredientsJsonList
        .map((ingredientsJson) => Ingredients.fromMap(ingredientsJson))
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addIngredients({
    required String name,
  }) async {
    // isLoading = true;
    // notifyListeners();

    // Dio client = Dio();

    var response =
        await Client.dio.post("http://10.0.2.2:8000/ingrediants/create/",
            data: FormData.fromMap({
              "name": name,
            }));

    await loadIngredients();
  }

  Future<void> deleteIngredients({
    required int id,
  }) async {
    var response = await Client.dio
        .delete("http://10.0.2.2:8000/ingrediants/delete/${id}/");
    loadIngredients();
  }
}
