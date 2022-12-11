import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/providers/dishes_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:foodiez_frontent/screens/cuisine/edit_cuisine.dart';
import 'package:foodiez_frontent/models/ingredients.dart';
import 'package:foodiez_frontent/providers/ingredients_provider.dart';

class Client {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: "http://127.0.0.1:8000"),
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.blue,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.blue,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.blue.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container SignUpOrInButton(
    BuildContext context, String title, Future Function() onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () async {
        await onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.blue;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

class CuisineStyle extends StatefulWidget {
  final Cuisine cuisine;
  const CuisineStyle({Key? key, required this.cuisine}) : super(key: key);

  @override
  State<CuisineStyle> createState() => _CuisineStyleState();
}

class _CuisineStyleState extends State<CuisineStyle> {
  final nameController = TextEditingController();
  File? imageFile;
  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.cuisine.name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              widget.cuisine.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Text(
                    widget.cuisine.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(232, 0, 0, 0),
                        fontSize: 22),
                  )),
                  ElevatedButton(
                    onPressed: () {
                      context.push("/dishes");
                    },
                    child: const Text("Show More"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () => context.push("/editcuisine"),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await context
                                .read<CuisineProvider>()
                                .deleteCuisine(id: widget.cuisine.id);
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DishStyle extends StatefulWidget {
  final Dish dish;
  const DishStyle({Key? key, required this.dish}) : super(key: key);

  @override
  State<DishStyle> createState() => _DishStyleState();
}

class _DishStyleState extends State<DishStyle> {
  final nameController = TextEditingController();
  File? imageFile;
  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.dish.name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              widget.dish.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Text(
                    widget.dish.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(232, 0, 0, 0),
                        fontSize: 22),
                  )),
                  ElevatedButton(
                    onPressed: () {
                      context.push("/detail");
                    },
                    child: const Text("Show Ingredients"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () => context.push("/editdish"),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await context
                                .read<DishProvider>()
                                .deleteDish(id: widget.dish.id);
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IngredientsStyle extends StatefulWidget {
  final Ingredients ingredient;
  const IngredientsStyle({Key? key, required this.ingredient})
      : super(key: key);

  @override
  State<IngredientsStyle> createState() => _IngredientsStyleState();
}

class _IngredientsStyleState extends State<IngredientsStyle> {
  final nameController = TextEditingController();
  File? imageFile;
  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.ingredient.name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Expanded(
          //   child: Image.network(
          //     widget.ingredients.image,
          //     fit: BoxFit.cover,
          //     width: double.infinity,
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    widget.ingredient.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(232, 0, 0, 0),
                        fontSize: 22),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () => context.push("/editingredients"),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await context
                                .read<IngredientsProvider>()
                                .deleteIngredients(id: widget.ingredient.id);
                            context.pop();
                            context.push("/ingredients");
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
