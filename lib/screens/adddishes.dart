import 'package:flutter/material.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/dishes_provider.dart';
import 'package:foodiez_frontent/models/dishes.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({Key? key}) : super(key: key);

  @override
  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final nameController = TextEditingController();
  File? imageData;
  bool isSubmitting = false;
  Cuisine? value;
  final _formKey = GlobalKey<FormState>();
  String? imageNull;

  @override
  Widget build(BuildContext context) {
    List<Dish> dishes =
        Provider.of<DishProvider>(context, listen: false).dishes;
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
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                enabled: !isSubmitting,
                decoration: InputDecoration(
                  hintText: "Dish Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required field";
                  }
                  return null;
                },
              ),
              if (imageData != null)
                Image.file(
                  imageData!,
                  height: 50,
                ),
              FormField<String>(
                validator: (value) {
                  if (imageData == null) {
                    return "Required image";
                  }
                  return null;
                },
                builder: (state) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: isSubmitting
                            ? null
                            : () async {
                                var image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                if (image == null) return;

                                setState(() {
                                  imageData = File(image.path);
                                });
                              },
                        child: Text("Add Image")),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: TextStyle(color: Colors.blue),
                      )
                  ],
                ),
              ),
              DropdownButton<Cuisine>(
                  value: value,
                  items: context
                      .watch<CuisineProvider>()
                      .cuisines
                      .map(buildMenuItem)
                      .toList(),
                  onChanged: (value) => setState(
                        () {
                          this.value = value;
                        },
                      )),
              Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    // form

                    if (imageData == null) {
                      setState(() {
                        imageNull = "Required field";
                      });
                    }

                    if (_formKey.currentState!.validate() &&
                        imageData != null) {
                      await context.read<DishProvider>().addDish(
                            name: nameController.text,
                            image: imageData!,
                            cuisine: value!.id,
                          );

                      context.push('/dishes');
                    }
                  },
                  child: Text("Add Dish"))
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<Cuisine> buildMenuItem(Cuisine item) => DropdownMenuItem(
        value: item,
        child: Text(item.name),
      );
}
