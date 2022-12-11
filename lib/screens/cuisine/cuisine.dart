import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:foodiez_frontent/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/providers/cuisine_provider.dart';

class CuisineScreen extends StatefulWidget {
  const CuisineScreen({Key? key}) : super(key: key);

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CuisineProvider>().loadCuisines();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: context.watch<CuisineProvider>().isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                context.read<CuisineProvider>().loadCuisines();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: LayoutBuilder(
                        builder: (context, c) {
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            physics:
                                const NeverScrollableScrollPhysics(), // <- Here
                            itemCount: context
                                .watch<CuisineProvider>()
                                .cuisines
                                .length,
                            itemBuilder: (context, index) => CuisineStyle(
                              cuisine: context
                                  .watch<CuisineProvider>()
                                  .cuisines[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
