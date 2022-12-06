import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatelessWidget {
  const Welcome({required this.username, Key? key}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Welcome To FOODIEZ!!")),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome $username"),
            Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 177, 202, 249),
              size: 140,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  child: Text("Countine .."),
                  onPressed: () {
                    context.go("/");
                  },
                ))
          ],
        ),
      ),
    );
  }
}
