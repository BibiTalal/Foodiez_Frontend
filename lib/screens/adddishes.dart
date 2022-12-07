import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();

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
          child: Column(children: [
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
            Spacer(),
            ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  setState(() {
                    isSubmitting = true;
                  });
                  await context.read<DishProvider>().addDish(
                        name: nameController.text,
                        image: imageData!,
                      );

                  context.pop();
                },
                child: Text("Add Dish")),
            // GridView.builder(
            //     // shrinkWrap: true,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       childAspectRatio: MediaQuery.of(context).size.width /
            //           (MediaQuery.of(context).size.height),
            //     ),
            //     // physics: const NeverScrollableScrollPhysics(),
            //     // itemCount: context.watch<CuisineProvider>().cuisines.length,
            //     itemBuilder: (context, index) =>
            //         CuisineStyle(cuisine: cuisines[index])),
          ]),
        )));
  }
}
