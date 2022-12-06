import 'package:flutter/material.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';
import 'package:foodiez_frontent/providers/add_cuisine_provider.dart';

class AddCuisineScreen extends StatelessWidget {
  const AddCuisineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cuisine> cuisines =
        Provider.of<CuisinesProvider>(context, listen: false).cuisines;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child:
                Text("Foodiez", style: TextStyle(fontWeight: FontWeight.bold)),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text("Home"),
                  onPressed: () {
                    context.push("/");
                  },
                )),
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: TextButton(
            //       child: Text("Logout"),
            //       onPressed: () {
            //         context.push("/logout");
            //       },
            //     ))
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.push("/addcuisine");
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Add Cuisine"),
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
              itemCount: context.watch<AddCuisineProvider>().addcuisines.length,
              itemBuilder: (context, index) =>
                  CuisineStyle(cuisine: cuisines[index])),
        ]),
      ),
    );
  }
}
