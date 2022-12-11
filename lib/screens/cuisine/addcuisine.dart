import 'package:flutter/material.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/rendering/box.dart';

class AddCuisineScreen extends StatefulWidget {
  const AddCuisineScreen({Key? key}) : super(key: key);

  @override
  @override
  State<AddCuisineScreen> createState() => _AddCuisineScreenState();
}

class _AddCuisineScreenState extends State<AddCuisineScreen> {
  final nameController = TextEditingController();
  File? imageData;
  bool isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Cuisine> cuisines =
        Provider.of<CuisineProvider>(context, listen: false).cuisines;
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
                hintText: "Cuisine Name",
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
                  // setState(() {
                  //   isSubmitting = true;
                  // });
                  await context.read<CuisineProvider>().addCuisine(
                        name: nameController.text,
                        image: imageData!,
                      );

                  context.pop();
                },
                child: Text("Add Cuisine")),
          ]),
        )));
  }
}
