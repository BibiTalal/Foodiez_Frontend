import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/widgets.dart';

class SignedIn extends StatelessWidget {
  const SignedIn({Key? key}) : super(key: key);

  // final String password;
  static const String _title = 'Foodiez';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Foodiez',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: reusableTextField("Enter UserName", Icons.person_outline,
                  false, nameController),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: reusableTextField("Enter Password", Icons.lock_outline,
                  true, passwordController),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SignUpOrInButton(
                  context,
                  "Sign In",
                  () {
                    if (passwordController.text == passwordController.text) {
                      print("success");
                      context.go("/welcome", extra: nameController.text);
                    } else {
                      print("fail");
                    }
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    context.push("/signup");
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}