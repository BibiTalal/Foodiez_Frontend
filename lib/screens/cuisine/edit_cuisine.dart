import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'dart:io';

class EditCuisine extends StatefulWidget {
  final Cuisine cuisine;
  EditCuisine({required this.cuisine});

  @override
  State<EditCuisine> createState() => _EditCuisineState();
}

class _EditCuisineState extends State<EditCuisine> {
  final nameController = TextEditingController();

  File? imageFile;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.cuisine.name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Edit"),
            backgroundColor: Color(0xFFf14b24),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required";
                    }

                    return null;
                  },
                ),
                Spacer(),
                if (imageFile != null)
                  Image.file(
                    imageFile!,
                    width: 100,
                    height: 100,
                  )
                else
                  Image.network(
                    widget.cuisine.image,
                    width: 100,
                    height: 100,
                  ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf14b24),
                        fixedSize: Size.fromWidth(150)),
                    onPressed: () async {
                      var file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (file == null) {
                        print("Use a file");
                        return;
                      }
                    },
                    child: Text("Add Image")),
                Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFff0000),
                            fixedSize: Size.fromWidth(150)),
                        onPressed: () async {
                          await context
                              .read<CuisineProvider>()
                              .deleteCuisine(id: widget.cuisine.id);
                          context.pop();
                        },
                        child: Text("Delete")),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFf14b24),
                            fixedSize: Size.fromWidth(150)),
                        onPressed: () async {
                          await context.read<CuisineProvider>().editCuisine(
                                id: widget.cuisine.id,
                                name: nameController.text,
                                image: imageFile,
                              );
                          context.pop();
                        },
                        child: Text("Save")),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
