import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/models/ingredients.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/ingredients_provider.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/providers/ingredients_provider.dart';
import 'package:foodiez_frontent/providers/ingredients_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddIngredientsScreen extends StatefulWidget {
  const AddIngredientsScreen({Key? key}) : super(key: key);

  @override
  State<AddIngredientsScreen> createState() => _AddIngredientsScreenState();
}

class _AddIngredientsScreenState extends State<AddIngredientsScreen> {
  final nameController = TextEditingController();

  bool isSubmitting = false;
  Cuisine? value;
  final _formKey = GlobalKey<FormState>();

  List<Ingredients> selectedIngredients = [];
  @override
  Widget build(BuildContext context) {
    List<Ingredients> ingredientss =
        Provider.of<IngredientsProvider>(context, listen: false).ingredients;
    return Scaffold(
        appBar: AppBar(
          title: Text("FOODIEZ"),
        ),
        // body: SingleChildScrollView(
        //     child: Column(children: [
        //   Row(children: [
        //     Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: TextButton(
        //           child: Text("Home"),
        //           onPressed: () {
        //             context.push("/");
        //           },
        //         )),
        //     // Padding(
        //     //     padding: const EdgeInsets.all(8.0),
        //     //     child: TextButton(
        //     //       child: Text("Logout"),
        //     //       onPressed: () {
        //     //         context.push("/logout");
        //     //       },
        //     //     ))
        //   ]),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         context.read<CuisineProvider>().addCuisine;
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.all(12.0),
        //         child: Text("Add Cuisine"),
        //       ),
        //     ),
        //   ),
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text("Home"),
                        onPressed: () {
                          context.push("/");
                        },
                      )),
                  TextFormField(
                    controller: nameController,
                    enabled: !isSubmitting,
                    decoration: InputDecoration(
                      hintText: "Ingredient Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      }
                      return null;
                    },
                  ),
                  FormField<String>(
                    builder: (state) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              // if (imageData == null) {
                              //   setState(() {
                              //     imageNull = "Required field";
                              //   });
                              // }

                              // if (_formKey.currentState!.validate() &&
                              //     imageData != null) {
                              await context
                                  .read<IngredientsProvider>()
                                  .addIngredients(
                                    name: nameController.text,
                                  );

                              context.push('/dishes');
                            },
                            child: Text("Add Ingredient")),
                        ElevatedButton(
                            onPressed: () async {
                              context.push('/ingredients');
                            },
                            child: Text("Ingredients List"))
                      ],
                    ),
                  )
                ]))));
  }
}
