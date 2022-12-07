import 'package:flutter/material.dart';
import 'package:foodiez_frontent/providers/auth_provider.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';
import 'package:foodiez_frontent/models/cuisine.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Cuisine> cuisines =
        Provider.of<CuisineProvider>(context, listen: false).cuisines;
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
          Row(
              children: context.watch<AuthProvider>().username == null
                  ? [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            child: Text("Sign In"),
                            onPressed: () {
                              context.push("/signin");
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            child: Text("Sign Up"),
                            onPressed: () {
                              context.push("/signup");
                            },
                          ))
                    ]
                  : [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            child: Text("SignOut"),
                            onPressed: () {
                              var authprovider = context.read<AuthProvider>();
                              authprovider.logout();
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.watch<AuthProvider>().username!),
                      )
                    ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.push("/addcuisine");
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Add a new Cuisine"),
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
              itemCount: context.watch<CuisineProvider>().cuisines.length,
              itemBuilder: (context, index) =>
                  CuisineStyle(cuisine: cuisines[index])),
        ]),
      ),
    );
  }
}
