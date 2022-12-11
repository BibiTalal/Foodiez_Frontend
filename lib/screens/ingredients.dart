import 'package:flutter/material.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/ingredients_provider.dart';
import 'package:foodiez_frontent/models/ingredients.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';

class IngredientsScreen extends StatelessWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ingredients> ingredients =
        Provider.of<IngredientsProvider>(context, listen: false).ingredients;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child:
                Text("Foodiez", style: TextStyle(fontWeight: FontWeight.bold)),
          )),
      // body: Column(children: [
      //   Row(children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: TextButton(
      //         child: Text("Sign Up"),
      //         onPressed: () {
      //           context.push("/signup");
      //         },
      //       ),
      //     ),
      //     Row(children: [
      //       Padding(
      //           padding: const EdgeInsets.all(20.0),
      //           child: TextButton(
      //             child: Text("Sign In"),
      //             onPressed: () {
      //               context.push("/signin");
      //             },
      //           )),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.push("/addingredients");
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Add a new Ingredients"),
              ),
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height),
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  context.watch<IngredientsProvider>().ingredients.length,
              itemBuilder: (context, index) =>
                  IngredientsStyle(ingredient: ingredients[index])),
        ]),
      ),
    );
  }
}
