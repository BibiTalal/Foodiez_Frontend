import 'package:foodiez_frontent/providers/ingredients_provider.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/models/ingredients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.dish});

  final Dish? dish;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Cuisine? cuisine;
  List<Ingredients> ingredientsName = [];

  @override
  void initState() {
    super.initState();

    cuisine = context
        .read<CuisineProvider>()
        .cuisines
        .firstWhere((element) => element.id == widget.dish!.cuisine);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dish!.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Ingredient: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${context.watch<IngredientsProvider>().ingredients.where((element) => widget.dish!.ingredients.contains(element.id)).toList().map((e) => e.name).join(' - ')}",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
